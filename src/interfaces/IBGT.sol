// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IBGT {
    function balanceOf(address account) external view returns (uint256);
    function redeem(address receiver, uint256 amount) external;
}

