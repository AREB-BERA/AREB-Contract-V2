// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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
