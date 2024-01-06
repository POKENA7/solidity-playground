// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract Deploy is Script {
    address L2_ERC721_GATEWAY = 0x880182579dff154bF9C976e0b814300f27c66ee7;

    ProxyAdmin proxyAdmin;

    function run() public {
        vm.startBroadcast();
        
        deployProxyAdmin();
        deployL2ERC721Gateway();

        vm.stopBroadcast();
    }

    function deployProxyAdmin() internal {
        proxyAdmin = new ProxyAdmin(msg.sender);

        logAddress("L2_PROXY_ADMIN_ADDR", address(proxyAdmin));
    }

    function deployL2ERC721Gateway() internal {
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            L2_ERC721_GATEWAY,
            address(proxyAdmin),
            new bytes(0)
        );

        logAddress("L2_ERC721_GATEWAY_PROXY_ADDR", address(proxy));
    }

    function logAddress(string memory name, address addr) internal view {
        console.log(string(abi.encodePacked(name, "=", vm.toString(address(addr)))));
    }
}
