// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";

interface IL1Gateway {
    function initialize(address _counterpart, address _messenger) external;
}

contract InitializeL1Gateway is Script {
    address L1_ERC721_GATEWAY_PROXY = 0x8CF45fF2c7124A3bA046eA768e204617fD487cEA;
    address L2_ERC721_GATEWAY_PROXY = 0xc6bF024d5939D7ac31A6a8A0B16E7f5b8A218d05;

    address L1_MESSENGER = 0x50c7d3e7f7c656493D1D76aaa1a836CedfCBB16A;

    function run() external {
        vm.startBroadcast();
        console.log("Initializing L1 Gateway");
        IL1Gateway(L1_ERC721_GATEWAY_PROXY).initialize(L2_ERC721_GATEWAY_PROXY, L1_MESSENGER);
        vm.stopBroadcast();
    }
}