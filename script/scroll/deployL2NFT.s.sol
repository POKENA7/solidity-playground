// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {BridgeERC721} from "../../src/scroll/BridgeERC721.sol";

contract DeployL2NFT is Script {
    address L1_ERC721_GATEWAY_PROXY = 0x8CF45fF2c7124A3bA046eA768e204617fD487cEA;
    address L2_ERC721_GATEWAY_PROXY = 0xc6bF024d5939D7ac31A6a8A0B16E7f5b8A218d05;

    function run() external {
        vm.startBroadcast();
        BridgeERC721 nft = new BridgeERC721(msg.sender);
        nft.setGateway(L2_ERC721_GATEWAY_PROXY);
        // nft.mint(msg.sender, 0);
        vm.stopBroadcast();
    }
}

// Contract Address: 0x1C4b56e223760BAF351d317Abe5390ca1de2eB7e
