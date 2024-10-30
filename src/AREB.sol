// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";

import {IHenloDexRouterV1} from "./interfaces/IHenloDexRouterV1.sol";
import {IHoneyManager} from "./interfaces/IHoneyManager.sol";

contract AREB is ERC20 {
    // Constant definitions
    uint256 private constant PURCHASE_TAX_RATE = 1; // 1%
    uint256 private constant SELL_TAX_RATE = 5;    // 5%
    
    // State variables
    IERC20 public immutable Honey;
    IHenloDexRouterV1 public immutable HenloDexRouter;
    IHoneyManager public immutable HoneyManager;
    uint256 public lastUpdateDay;
    address public Areb_Honey_Market;
    address public owner;
    uint256 public accumulatedTax;
    uint256 public checkEpochTick;

    // Events
    event TaxCollected(uint256 amount, TaxType taxType);
    event BuybackExecuted(uint256 amount);
    
    // Enums
    enum TaxType { Purchase, Sell }

    constructor(
        uint256 initialSupply,
        address _honey,
        address _HenloRouter,
        address _honeyManager,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        Honey = IERC20(_honey);
        HenloDexRouter = IHenloDexRouterV1(_HenloRouter);
        HoneyManager = IHoneyManager(_honeyManager);
        lastUpdateDay = (block.timestamp - (block.timestamp % 1 days)) / (1 days);
        owner = msg.sender;
    }

    function definePair(address lpAddress) public {
        require(msg.sender == owner, "Not authorized");
        Areb_Honey_Market = lpAddress;
        owner = address(0);
    }

    modifier checkEpoch(address from) {
        _checkEpochAndBuyback(from);
        _;
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override checkEpoch(from) {
        uint256 valueToAddToReceiver = value;

        if (from == address(0)) {
            // Use parent contract's _update for minting
            super._update(from, to, value);
            return;
        } 
        
        // Check if the transfer is from the Honey market
        if (from == Areb_Honey_Market && 
            to != address(this) && 
            to != address(HoneyManager)) {
            // Buy operation
            uint256 fromBalance = balanceOf(from);
            if (fromBalance < value) {
                revert("ERC20: transfer amount exceeds balance");
            }
            
            // Calculate purchase tax
            uint256 purchaseTax = (value * PURCHASE_TAX_RATE) / 100;
            accumulatedTax += purchaseTax;
            valueToAddToReceiver = value - purchaseTax;
            
            super._update(from, address(this), purchaseTax);
            super._update(from, to, valueToAddToReceiver);
            
            emit TaxCollected(purchaseTax, TaxType.Purchase);
            return;
        }

        // Check if the transfer is to the Honey market
        if (to == Areb_Honey_Market && from != address(this)) {
            // Sell operation
            uint256 sellTax = (value * SELL_TAX_RATE) / 100;
            valueToAddToReceiver = value - sellTax;
            
            super._update(from, address(this), sellTax);
            super._update(from, to, valueToAddToReceiver);
            
            accumulatedTax += sellTax;
            emit TaxCollected(sellTax, TaxType.Sell);

            // Swap accumulated tokens if needed
            if (accumulatedTax > 0) {
                _swapAccumulatedTax();
            }
            return;
        }

        // For other cases, use the standard implementation of the parent contract
        super._update(from, to, value);
    }

    function _swapAccumulatedTax() internal {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = address(Honey);
        
        _approve(address(this), address(HenloDexRouter), accumulatedTax);
        
        HenloDexRouter.swapExactTokensForTokens(
            accumulatedTax,
            0,
            path,
            address(HoneyManager),
            block.timestamp + 600
        );
        
        uint256 swappedAmount = accumulatedTax;
        accumulatedTax = 0;
        
        // Add liquidity and stake
        HoneyManager.addLiquidityAndStake();
        
        emit BuybackExecuted(swappedAmount);
    }

    function _checkEpochAndBuyback(address from) internal {
        uint256 currentDay = (block.timestamp - (block.timestamp % 1 days)) / (1 days);
        
        // Check if it's a new day and the sender is not the Honey market
        if (from != Areb_Honey_Market && currentDay > lastUpdateDay) {
            checkEpochTick++;
            lastUpdateDay = currentDay;
            HoneyManager.claimBgtAndBuyBack();
        }
    }
}
