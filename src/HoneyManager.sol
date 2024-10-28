// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IBeraCrocMultiSwap, SwapStep} from "./interfaces/IBeraCrocMultiSwap.sol";
import {ICrocSwapDex} from "./interfaces/ICrocSwapDex.sol";
import {IStakingVault} from "./interfaces/IStakingVault.sol";
import {IBGT} from "./interfaces/IBGT.sol";
import {IHenloDexRouterV1} from "./interfaces/IHenloDexRouterV1.sol";
import {AREB} from "../src/AREB.sol";

// errors
error Unauthorized();
error InvalidAddress();
error SwapFailed();
error StakingFailed();
error InsufficientBalance();

contract HoneyManager {
    // constants
    uint256 private constant POOL_IDX = 36000;
    uint16 private constant CALLPATH = 128;
    uint8 private constant ADD_LIQUIDITY_CODE = 32;

    // Immutable state variables
    IERC20 public immutable Honey;
    IERC20 public immutable USDC;
    IERC20 public immutable Honey_USDC_BEX_LP;
    IERC20 public immutable WBERA;
    IBeraCrocMultiSwap public immutable BexMultiSwap;
    ICrocSwapDex public immutable CrocSwapDex;
    IStakingVault public immutable StakingVault;
    IBGT public immutable BGT;
    IHenloDexRouterV1 public immutable HenloDexRouter;

    // state variables
    address public owner;
    address public ArebContract;
    uint256 public flag = 100;
    AREB public AREB_TOKEN;

    // events
    event LiquidityAdded(
        uint256 honeyAmount,
        uint256 usdcAmount,
        uint256 lpAmount
    );
    event BGTClaimed(uint256 amount);
    event ArebBurned(uint256 amount);
    event ContractInitialized(address arebContract);

    constructor(
        address _honey,
        address _usdc,
        address _lpConduit,
        address _wbera,
        address _BexMultiSwap,
        address _CrocSwapDex,
        address _stakingVault,
        address _bgt,
        address _HenloRouter
    ) {
        if (_honey == address(0) || _usdc == address(0))
            revert InvalidAddress();

        Honey = IERC20(_honey);
        USDC = IERC20(_usdc);
        Honey_USDC_BEX_LP = IERC20(_lpConduit);
        WBERA = IERC20(_wbera);
        BexMultiSwap = IBeraCrocMultiSwap(_BexMultiSwap);
        CrocSwapDex = ICrocSwapDex(_CrocSwapDex);
        StakingVault = IStakingVault(_stakingVault);
        BGT = IBGT(_bgt);
        HenloDexRouter = IHenloDexRouterV1(_HenloRouter);
        owner = msg.sender;
    }

    modifier onlyAreb() {
        if (msg.sender != ArebContract) revert Unauthorized();
        _;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert Unauthorized();
        _;
    }

    function defineAreb(address _areb) external onlyOwner {
        if (_areb == address(0)) revert InvalidAddress();
        ArebContract = _areb;
        AREB_TOKEN = AREB(_areb);
        owner = address(0);
        emit ContractInitialized(_areb);
    }

    function addLiquidityAndStake() external onlyAreb {
        _addLiquidityAndStake();
    }

    function claimBgtAndBuyBack() external onlyAreb {
        // 1. Claim BGT rewards
        uint256 bgtYieldFromVault = StakingVault.getReward(address(this));
        emit BGTClaimed(bgtYieldFromVault);

        // 2. Convert BGT to BERA
        BGT.redeem(address(this), bgtYieldFromVault);

        // 3. Buy AREB with BERA
        uint256 arebAmount = _swapBeraForAreb(bgtYieldFromVault);

        // 4. Burn AREB
        AREB_TOKEN.transfer(address(1), arebAmount);
        emit ArebBurned(arebAmount);
    }

    function _addLiquidityAndStake() internal {
        // 1. Calculate amounts
        uint256 initialHoneyBalance = Honey.balanceOf(address(this));
        uint256 half = initialHoneyBalance / 2;
        if (half == 0) revert InsufficientBalance();

        // 2. Swap half Honey to USDC
        uint128 usdcAmount = _swapHoneyToUsdc(uint128(half));

        // 3. Approve tokens
        Honey.approve(address(CrocSwapDex), half * 2);
        USDC.approve(address(CrocSwapDex), uint256(usdcAmount) * 2);

        // 4. Add liquidity
        _addLiquidityToBex(usdcAmount);

        // 5. Stake LP tokens
        uint256 lpBalance = Honey_USDC_BEX_LP.balanceOf(address(this));
        if (lpBalance == 0) revert StakingFailed();

        Honey_USDC_BEX_LP.approve(address(StakingVault), lpBalance);
        StakingVault.stake(lpBalance);

        emit LiquidityAdded(half, usdcAmount, lpBalance);
    }

    function _swapHoneyToUsdc(uint128 amount) internal returns (uint128) {
        SwapStep[] memory steps = new SwapStep[](1);
        steps[0] = SwapStep({
            poolIdx: POOL_IDX,
            base: address(Honey),
            quote: address(USDC),
            isBuy: true
        });

        Honey.approve(address(BexMultiSwap), amount);
        uint128 usdcReceived = BexMultiSwap.multiSwap(steps, amount, 0);
        if (usdcReceived == 0) revert SwapFailed();

        return usdcReceived;
    }

    function _swapBeraForAreb(uint256 amount) internal returns (uint256) {
        WBERA.approve(address(HenloDexRouter), amount);

        address[] memory path = new address[](3);
        path[0] = address(WBERA);
        path[1] = address(Honey);
        path[2] = address(AREB_TOKEN);

        uint256[] memory results = HenloDexRouter.swapExactETHForTokens{
            value: amount
        }(0, path, address(this), block.timestamp + 600);

        if (results.length == 0) revert SwapFailed();
        return results[results.length - 1];
    }

    function _addLiquidityToBex(uint128 qty) internal {
        bytes memory cmd = abi.encode(
            ADD_LIQUIDITY_CODE,
            address(Honey),
            address(USDC),
            POOL_IDX,
            int24(0), // bidTick
            int24(0), // askTick
            qty,
            uint128(0), // limitLower
            type(uint128).max, // limitHigher
            uint8(0), // settleFlags
            address(Honey_USDC_BEX_LP)
        );

        CrocSwapDex.userCmd(CALLPATH, cmd);
    }

    receive() external payable {}
}
