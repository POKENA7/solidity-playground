// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/proxy/Clones.sol";

contract Factory {
    address public immutable implementation;
    address[] public instances;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function createInstance() external {
        address instance = Clones.clone(implementation);
        instances.push(instance);
    }
}