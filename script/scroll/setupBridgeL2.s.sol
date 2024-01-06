// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {BridgeERC721} from "../../src/scroll/BridgeERC721.sol";

interface IL2Gateway {
    function updateTokenMapping(address _l2Token, address _l1Token) external;
}

contract SetupBridgeL2 is Script {
    address L1_ERC721_GATEWAY_PROXY = 0x8CF45fF2c7124A3bA046eA768e204617fD487cEA;
    address L2_ERC721_GATEWAY_PROXY = 0xc6bF024d5939D7ac31A6a8A0B16E7f5b8A218d05;
    address L1_ERC721 = 0x18cC97fffBBEEE7C6896c7688A3eB984e9281b68;
    address L2_ERC721 = 0x1C4b56e223760BAF351d317Abe5390ca1de2eB7e;

    function run() external {
        vm.startBroadcast();
        BridgeERC721(L2_ERC721).setCounterpart(L1_ERC721);
        IL2Gateway(L2_ERC721_GATEWAY_PROXY).updateTokenMapping(L2_ERC721, L1_ERC721);
        vm.stopBroadcast();
    }
}
