// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyStructs {
    
    struct NFT {
        string name;
        uint256 dna;
    }

    NFT[] public nftList;
    
    function addNFT(string memory _name, uint256 _dna) public {
        // NFT memory newNFT;
        // newNFT.name = _name;
        // newNFT.dna = _dna;
        NFT memory newNFT = NFT(_name, _dna);
        nftList.push(newNFT);
    }
    
    function addNFTS(NFT[] calldata _nfts) public {
        nftList = _nfts;
    }
    
    function updateNFTStorage(uint256 _index, string memory _name) public {
        require(_index < nftList.length, "Index out of bound error");
        // Reference : https://www.quicknode.com/guides/ethereum-development/smart-contracts/a-dive-into-evm-architecture-and-opcodes
        NFT storage nftToBeUpdated = nftList[_index];
        nftToBeUpdated.name = _name;
    }
    
    function updateNFTMemory(uint256 _index, string memory _name) public {
        require(_index < nftList.length, "Index out of bound error");
        NFT memory nftToBeUpdated = nftList[_index];
        nftToBeUpdated.name = _name;
        nftList[_index] = nftToBeUpdated;
    }
    
    function getNftName(uint256 _index) public view returns(string memory){
        require(_index < nftList.length, "Index out of bound error");
        return nftList[_index].name;
    }
}