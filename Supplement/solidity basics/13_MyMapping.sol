// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyMappings {
    mapping(uint256 => address) nfts;
    uint256 counter = 0;
    
    function getOwnerOfNFT(uint256 _id) public view returns (address) {
        // get value from mapping
        return nfts[_id];
    }
    
    function mintNFT(address _address) public {
        // set the value in mapping
        nfts[counter] = _address;
        counter++;
    }
    
}
