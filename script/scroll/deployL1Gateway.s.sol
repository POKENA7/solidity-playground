// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract Deploy is Script {
    address L1_ERC721_GATEWAY = 0x4f31dd97B4C2fb3cD51DE320ff0D814C1514C7f3;

    ProxyAdmin proxyAdmin;

    function run() external {
        vm.startBroadcast();
        
        deployProxyAdmin();
        deployL1Gateway();

        vm.stopBroadcast();
    }

    function deployProxyAdmin() internal {
        proxyAdmin = new ProxyAdmin(msg.sender);

        logAddress("L1_PROXY_ADMIN_ADDR", address(proxyAdmin));
    }

    function deployL1Gateway() internal {
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            L1_ERC721_GATEWAY,
            address(proxyAdmin),
            new bytes(0)
        );

        logAddress("L1_ERC721_GATEWAY_PROXY_ADDR", address(proxy));
    }

    function logAddress(string memory name, address addr) internal view {
        console.log(string(abi.encodePacked(name, "=", vm.toString(address(addr)))));
    }
}
