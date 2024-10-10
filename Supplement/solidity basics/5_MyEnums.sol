// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyEnums {
    enum Rarity {
        original,
        rare, 
        super_rare
    }
    
    Rarity public rarity;

    address public admin;

    constructor() {
        rarity = Rarity.original;
        admin = msg.sender; 
    }
    
    function updateRarity(Rarity _rarity) public {
        require(msg.sender == admin, "Only admin can update rarity");
        rarity = _rarity;
    }

    function getCurrentRarity() public view returns (Rarity) {
        return rarity;
    }
}

