// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {ERC2771Forwarder} from "@openzeppelin/contracts/metatx/ERC2771Forwarder.sol";

contract Forwarder is ERC2771Forwarder {
    constructor(address trustedForwarder) ERC2771Forwarder("Forwarder") {}
}