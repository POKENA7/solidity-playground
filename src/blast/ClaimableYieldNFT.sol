// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IBlast} from "./IBlast.sol";

contract ClaimableYieldNFT is ERC721, Ownable {
    constructor() ERC721("NFT", "NFT") Ownable(msg.sender) {
        IBlast(0x4300000000000000000000000000000000000002).configureClaimableYield();
    }

    uint256 private _ids = 0;

    function mint() external {
        _mint(msg.sender, _ids);
        _ids++;
    }

    function claimYield(address recipient, uint256 amount) external {
	    //This function is public meaning anyone can claim the yield
		IBlast(0x4300000000000000000000000000000000000002).claimYield(address(this), recipient, amount);
    }

	function claimAllYield(address recipient) external {
	    //This function is public meaning anyone can claim the yield
	    IBlast(0x4300000000000000000000000000000000000002).claimAllYield(address(this), recipient);
    }

    function readClimableYield() external view returns (uint256) {
        return IBlast(0x4300000000000000000000000000000000000002).readClaimableYield(address(this));
    }

    function withdraw() external onlyOwner {
        //This function is public meaning anyone can withdraw the ETH
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {
        //This function is public meaning anyone can send ETH to the contract
    }
}