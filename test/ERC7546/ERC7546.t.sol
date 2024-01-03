// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {ERC7546Proxy} from "../../src/ERC7546/ERC7546Proxy.sol";
import {Dictionary} from "../../src/ERC7546/Dictionary.sol";
import {Impl1} from "../../src/ERC7546/Impl1.sol";
import {Impl2} from "../../src/ERC7546/Impl2.sol";

contract ERC7546Test is Test {
    address private admin;
    uint private constant ADMIN_ADDRESS_KEY = 1;

    ERC7546Proxy proxy;
    Dictionary dictionary;
    Impl1 impl1;
    Impl2 impl2;
    Impl1 wrappedImpl1;

    function setUp() public {
        admin = vm.addr(ADMIN_ADDRESS_KEY);

        dictionary = new Dictionary(admin);
        impl1 = new Impl1();
        impl2 = new Impl2();
        proxy = new ERC7546Proxy(address(dictionary), "");
        wrappedImpl1 = Impl1(address(proxy));
    }

    function testSetImpl1() public {
        vm.startPrank(admin);
        bytes4 functionSelector = bytes4(keccak256("plus(uint256,uint256)"));
        bytes4 functionSelector2 = bytes4(keccak256("getNum()"));

        dictionary.setImplementation(functionSelector, address(impl1));
        dictionary.setImplementation(functionSelector2, address(impl1));

        wrappedImpl1.plus(1, 2);
        assertEq(wrappedImpl1.getNum(), 3);

        vm.stopPrank();
    }
}