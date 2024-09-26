// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyConstructor {
    
    string public name;
    
    constructor(string memory _name) {
        name = _name;
    }

    // TODO : Write getter and setter functions for name

}

contract MySecondContract is MyConstructor {
    constructor(string memory _name) MyConstructor(_name) {}
}