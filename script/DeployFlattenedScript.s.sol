// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

// 这里使用合并后的合约
import "../src/flattened/HoneyManager.sol";

contract DeployFlattenedScript is Script {
    // Token addresses on mainnet
    address constant HONEY = 0x0E4aaF1351de4c0264C5c7056Ef3777b41BD8e03;
    address constant USDC = 0xd6D83aF58a19Cd14eF3CF6fe848C9A4d21e5727c;
    address constant HONEY_USDC_PAIR = 0xD69ADb6FB5fD6D06E6ceEc5405D95A37F96E3b96;
    address constant WBERA = 0x7507c1dc16935B82698e4C63f2746A2fCf994dF8;
    address constant BEX_MULTI_SWAP = 0x21e2C0AFd058A89FCf7caf3aEA3cB84Ae977B73D;
    address constant CROC_SWAP_DEX = 0xAB827b1Cc3535A9e549EE387A6E9C3F02F481B49;
    address constant STAKING_VAULT = 0xe3b9B72ba027FD6c514C0e5BA075Ac9c77C23Afa;
    address constant BGT = 0xbDa130737BDd9618301681329bF2e46A016ff9Ad;
    address constant HENLO_ROUTER = 0x482270069fF98a0dF528955B651494759b3B2F8C;

    function deploy() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_KEY");
        string memory name = vm.envString("TOKEN_NAME");
        string memory symbol = vm.envString("TOKEN_SYMBOL");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy HoneyManager
        HoneyManager honeyManager = new HoneyManager(
            HONEY,
            USDC,
            HONEY_USDC_PAIR,
            WBERA,
            BEX_MULTI_SWAP,
            CROC_SWAP_DEX,
            STAKING_VAULT,
            BGT,
            HENLO_ROUTER
        );

        // Deploy AREB with initial supply
        uint256 initialSupply = 100_000_000 * 10 ** 18; // 100M tokens with 18 decimals
        AREB areb = new AREB(
            initialSupply,
            HONEY,
            HENLO_ROUTER,
            address(honeyManager),
            name,
            symbol
        );

        // Initialize HoneyManager with AREB address
        honeyManager.defineAreb(address(areb));

        vm.stopBroadcast();

        // Log deployed addresses
        console.log("HoneyManager deployed to:", address(honeyManager));
        console.log("AREB deployed to:", address(areb));
    }
}