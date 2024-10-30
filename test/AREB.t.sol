// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {AREB} from "../src/AREB.sol";
import {HoneyManager} from "../src/HoneyManager.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IHenloDexRouterV1} from "../src/interfaces/IHenloDexRouterV1.sol";

contract AREBTest is Test {
    AREB public areb;
    HoneyManager public honeyManager;

    // Known contract addresses
    address constant HONEY = 0x0E4aaF1351de4c0264C5c7056Ef3777b41BD8e03;
    address constant USDC = 0xd6D83aF58a19Cd14eF3CF6fe848C9A4d21e5727c;
    address constant HONEY_USDC_PAIR =
        0xD69ADb6FB5fD6D06E6ceEc5405D95A37F96E3b96;
    address constant WBERA = 0x7507c1dc16935B82698e4C63f2746A2fCf994dF8;
    address constant BEX_MULTI_SWAP =
        0x21e2C0AFd058A89FCf7caf3aEA3cB84Ae977B73D;
    address constant CROC_SWAP_DEX = 0xAB827b1Cc3535A9e549EE387A6E9C3F02F481B49;
    address constant STAKING_VAULT = 0xe3b9B72ba027FD6c514C0e5BA075Ac9c77C23Afa;
    address constant BGT = 0xbDa130737BDd9618301681329bF2e46A016ff9Ad;
    address constant HENLO_ROUTER = 0x482270069fF98a0dF528955B651494759b3B2F8C;

    address public owner;
    uint256 public constant INITIAL_SUPPLY = 1000000 * 10 ** 18;
    uint256 mainnetFork;

    function setUp() public {
        // Fork the network
        mainnetFork = vm.createFork(vm.envString("BERACHAIN_RPC_URL"));
        vm.selectFork(mainnetFork);

        // Setup owner account
        owner = makeAddr("owner");
        vm.deal(owner, 100 ether);
        console2.log("Owner address:", owner);

        vm.startPrank(owner);

        // Deploy HoneyManager first
        try
            new HoneyManager(
                HONEY,
                USDC,
                HONEY_USDC_PAIR,
                WBERA,
                BEX_MULTI_SWAP,
                CROC_SWAP_DEX,
                STAKING_VAULT,
                BGT,
                HENLO_ROUTER
            )
        returns (HoneyManager _honeyManager) {
            honeyManager = _honeyManager;
            console2.log("HoneyManager deployed at:", address(honeyManager));
        } catch Error(string memory reason) {
            console2.log("HoneyManager deployment failed:", reason);
            revert("HoneyManager deployment failed");
        }

        // Deploy AREB token
        try
            new AREB(
                INITIAL_SUPPLY,
                HONEY,
                HENLO_ROUTER,
                address(honeyManager),
                "AREB",
                "AREB"
            )
        returns (AREB _areb) {
            areb = _areb;
            console2.log("AREB deployed at:", address(areb));
        } catch Error(string memory reason) {
            console2.log("AREB deployment failed:", reason);
            revert("AREB deployment failed");
        }

        // Initialize HoneyManager with AREB address
        try honeyManager.defineAreb(address(areb)) {
            console2.log("AREB address set in HoneyManager");
        } catch Error(string memory reason) {
            console2.log("defineAreb failed:", reason);
            revert("defineAreb failed");
        }

        vm.stopPrank();
    }

    // Basic test to check deployment
    function testDeployment() public {
        assertTrue(address(areb) != address(0), "AREB not deployed");
        assertTrue(
            address(honeyManager) != address(0),
            "HoneyManager not deployed"
        );
        assertEq(areb.totalSupply(), INITIAL_SUPPLY, "Wrong initial supply");
        assertEq(areb.balanceOf(owner), INITIAL_SUPPLY, "Wrong owner balance");
    }
}
