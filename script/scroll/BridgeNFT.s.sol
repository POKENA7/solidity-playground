// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {BridgeERC721} from "../../src/scroll/BridgeERC721.sol";

interface IL1Gateway {
    function depositERC721(
        address _token,
        uint256 _tokenId,
        uint256 _gasLimit
    ) external payable;
}

contract BridgeNFT is Script {
    address L1_ERC721_GATEWAY_PROXY = 0x8CF45fF2c7124A3bA046eA768e204617fD487cEA;
    address L2_ERC721_GATEWAY_PROXY = 0xc6bF024d5939D7ac31A6a8A0B16E7f5b8A218d05;
    address L1_ERC721 = 0x18cC97fffBBEEE7C6896c7688A3eB984e9281b68;
    address L2_ERC721 = 0x1C4b56e223760BAF351d317Abe5390ca1de2eB7e;

    function run() external {
        vm.startBroadcast();
        BridgeERC721(L1_ERC721).setApprovalForAll(L1_ERC721_GATEWAY_PROXY, true);
        IL1Gateway(L1_ERC721_GATEWAY_PROXY).depositERC721{ value: 0.01 ether}(L1_ERC721, 0, 1000000);
        vm.stopBroadcast();
    }
}
