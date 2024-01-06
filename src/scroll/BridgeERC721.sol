// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

interface IScrollERC721 {
  /// @notice Return the address of Gateway the token belongs to.
  function gateway() external view returns (address);

  /// @notice Return the address of counterpart token.
  function counterpart() external view returns (address);

  /// @notice Mint some token to recipient's account.
  /// @dev Gateway Utilities, only gateway contract can call
  /// @param _to The address of recipient.
  /// @param _tokenId The token id to mint.
  function mint(address _to, uint256 _tokenId) external;

  /// @notice Burn some token from account.
  /// @dev Gateway Utilities, only gateway contract can call
  /// @param _tokenId The token id to burn.
  function burn(uint256 _tokenId) external;
}

contract BridgeERC721 is ERC721, IScrollERC721, Ownable {
    address private _gateway;
    address private _Contract;

    constructor(address owner)
        ERC721("NFT", "NFT") 
        Ownable(owner)
    {}

    function gateway() external view override returns (address) {
        return _gateway;
    }

    function counterpart() external view override returns (address) {
        return _Contract;
    }

    function mint(address _to, uint256 _tokenId) external override {
        _mint(_to, _tokenId);
    }

    function burn(uint256 _tokenId) external override {
        _burn(_tokenId);
    }

    function setGateway(address newGateway) external {
        _gateway = newGateway;
    }

    function setCounterpart(address newCounterpart) external {
        _Contract = newCounterpart;
    }
}