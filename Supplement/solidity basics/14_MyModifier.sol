// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyModifier {
    
    uint256 public myNum = 0;
    bool public paused = false;
    address public owner; // variable that will store the admin address
    
    constructor () {
        // this is called once 
        // during deployment
        // at that time owner will be set as 
        // the person who is deploying the smart contract
        // msg.sender => the person interacting with the smart contract
        owner = address(msg.sender);
    }

    modifier isNotPaused(bool _bypass) {
        if(_bypass == true) {
            require(paused == false, "Contract is paused");
        }
        _;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
        // emit
    }
    
    function setPaused() public onlyOwner {
        // it will check if the person calling this 
        // is same as owner variable
        paused = true;
    }
    
    function addToNum() public isNotPaused(true)  {
        myNum++;
    }
   
     function sunFromNum() public isNotPaused(true) {
        myNum--;
    }

}