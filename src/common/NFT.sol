// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    constructor() ERC721("NFT", "NFT") {}

    uint256 private _ids = 0;

    function mint() external {
        _mint(msg.sender, _ids);
        _ids++;
    }
}