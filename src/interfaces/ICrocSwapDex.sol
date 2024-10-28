// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface ICrocSwapDex {
    function userCmd(uint16 callpath, bytes calldata cmd) external payable returns (bytes memory);
}

