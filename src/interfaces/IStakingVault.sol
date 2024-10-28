// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IStakingVault {
    function stake(uint256 _amount) external;
    function getReward(address account) external returns (uint256);
}

