// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../../src/EIP1153/ERC20Permit.sol";
import {SigUtils} from "../../src/EIP1153/SigUtils.sol";

contract ERC20PermitTest is Test {
    address private admin;
    uint private constant ADMIN_ADDRESS_KEY = 1;

    MyToken token;
    SigUtils sigUtils;

    function setUp() public {
        admin = vm.addr(ADMIN_ADDRESS_KEY);
        token = new MyToken();
        sigUtils = new SigUtils(token.DOMAIN_SEPARATOR());
    }

    function testPermit() public {
        (address user, uint256 key) = makeAddrAndKey("alice");
        token.mint(user, 100);
        assertEq(token.balanceOf(user), 100);

        SigUtils.Permit memory permit = SigUtils.Permit({
            owner: user,
            spender: admin,
            value: 100,
            nonce: 0,
            deadline: 1 days
        });

        bytes32 digest = sigUtils.getTypedDataHash(permit);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(key, digest);

        vm.startPrank(admin);
        token.permit(user, admin, 100, 1 days, v, r, s);
        token.transferFrom(user, admin, 100);
        vm.stopPrank();

        assertEq(token.balanceOf(admin), 100);
        assertEq(token.balanceOf(user), 0);
    }


}