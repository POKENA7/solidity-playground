// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {Factory} from "../../src/clone/Factory.sol";
import {NFT} from "../../src/common/NFT.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        NFT nft = new NFT();
        Factory factory = new Factory(address(nft));
        factory.createInstance();
        vm.stopBroadcast();
    }
}
