// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyEnums {
    // TODO : makeSuperRare : Only allow admin to update the rarity
    // TODO : makeSuperRare : Update to accept the type of rarity
    // TODO : Add get function ( without check ) to get the current rarity

    enum Rarity {
        original, // 0
        rare, // 1
        super_rare // 2
    }
    
    Rarity public rarity;
    
    constructor() {
        rarity = Rarity.rare;
    }
    
    function makeSuperRare() public {
        rarity = Rarity.super_rare;
    }
}

