// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13 ^0.8.17 ^0.8.20;

// lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol

// OpenZeppelin Contracts (last updated v5.1.0) (interfaces/draft-IERC6093.sol)

/**
 * @dev Standard ERC-20 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-20 tokens.
 */
interface IERC20Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC20InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `spender`’s `allowance`. Used in transfers.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     * @param allowance Amount of tokens a `spender` is allowed to operate with.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC20InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `spender` to be approved. Used in approvals.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC20InvalidSpender(address spender);
}

/**
 * @dev Standard ERC-721 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-721 tokens.
 */
interface IERC721Errors {
    /**
     * @dev Indicates that an address can't be an owner. For example, `address(0)` is a forbidden owner in ERC-20.
     * Used in balance queries.
     * @param owner Address of the current owner of a token.
     */
    error ERC721InvalidOwner(address owner);

    /**
     * @dev Indicates a `tokenId` whose `owner` is the zero address.
     * @param tokenId Identifier number of a token.
     */
    error ERC721NonexistentToken(uint256 tokenId);

    /**
     * @dev Indicates an error related to the ownership over a particular token. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param tokenId Identifier number of a token.
     * @param owner Address of the current owner of a token.
     */
    error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC721InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC721InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param tokenId Identifier number of a token.
     */
    error ERC721InsufficientApproval(address operator, uint256 tokenId);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC721InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC721InvalidOperator(address operator);
}

/**
 * @dev Standard ERC-1155 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-1155 tokens.
 */
interface IERC1155Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     * @param tokenId Identifier number of a token.
     */
    error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC1155InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC1155InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param owner Address of the current owner of a token.
     */
    error ERC1155MissingApprovalForAll(address operator, address owner);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC1155InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC1155InvalidOperator(address operator);

    /**
     * @dev Indicates an array length mismatch between ids and values in a safeBatchTransferFrom operation.
     * Used in batch transfers.
     * @param idsLength Length of the array of token identifiers
     * @param valuesLength Length of the array of token amounts
     */
    error ERC1155InvalidArrayLength(uint256 idsLength, uint256 valuesLength);
}

// lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol

// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/IERC20.sol)

/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// lib/openzeppelin-contracts/contracts/utils/Context.sol

// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// src/interfaces/IBGT.sol

interface IBGT {
    function balanceOf(address account) external view returns (uint256);
    function redeem(address receiver, uint256 amount) external;
}

// src/interfaces/IBeraCrocMultiSwap.sol

struct SwapStep {
    uint256 poolIdx;
    address base;
    address quote;
    bool isBuy;
}

interface IBeraCrocMultiSwap {
    function multiSwap(
        SwapStep[] memory _steps,
        uint128 _amount,
        uint128 _minOut
    ) external payable returns (uint128 out);
}

// src/interfaces/ICrocSwapDex.sol

interface ICrocSwapDex {
    function userCmd(uint16 callpath, bytes calldata cmd) external payable returns (bytes memory);
}

// src/interfaces/IHenloDexRouterV1.sol

interface IHenloDexRouterV1 {
  function factory() external view returns (address);

    function WETH() external view returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function swapTokensForExactETH(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapETHForExactTokens(
        uint amountOut,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function quote(
        uint amountA,
        uint reserveA,
        uint reserveB
    ) external pure returns (uint amountB);

    function getAmountOut(
        uint amountIn,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountOut);

    function getAmountIn(
        uint amountOut,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountIn);

    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    function getAmountsIn(
        uint amountOut,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

// src/interfaces/IHoneyManager.sol

interface IHoneyManager {
    function addLiquidityAndStake() external;

    function claimBgtAndBuyBack() external;
}

// src/interfaces/IStakingVault.sol

interface IStakingVault {
    function stake(uint256 _amount) external;
    function getReward(address account) external returns (uint256);
}

// lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol

// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/extensions/IERC20Metadata.sol)

/**
 * @dev Interface for the optional metadata functions from the ERC-20 standard.
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol

// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/ERC20.sol)

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC-20
 * applications.
 */
abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address account => uint256) private _balances;

    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `value`.
     */
    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Skips emitting an {Approval} event indicating an allowance update. This is not
     * required by the ERC. See {xref-ERC20-_approve-address-address-uint256-bool-}[_approve].
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `value`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `value`.
     */
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

    /**
     * @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
     * (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
     * this function.
     *
     * Emits a {Transfer} event.
     */
    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            // Overflow check required: The rest of the code assumes that totalSupply never overflows
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                // Overflow not possible: value <= fromBalance <= totalSupply.
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
                _totalSupply -= value;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    /**
     * @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    /**
     * @dev Sets `value` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     *
     * Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    /**
     * @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
     *
     * By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
     * `_spendAllowance` during the `transferFrom` operation set the flag to false. This saves gas by not emitting any
     * `Approval` event during `transferFrom` operations.
     *
     * Anyone who wishes to continue emitting `Approval` events on the`transferFrom` operation can force the flag to
     * true using the following override:
     *
     * ```solidity
     * function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
     *     super._approve(owner, spender, value, true);
     * }
     * ```
     *
     * Requirements are the same as {_approve}.
     */
    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `value`.
     *
     * Does not update the allowance value in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Does not emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}

// src/AREB.sol

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

// src/HoneyManager.sol

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

