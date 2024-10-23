// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyModifier {
    
    uint256 public myNum = 0;
    bool public paused = false;
    address public owner;
    
    constructor () {
        owner = address(msg.sender);
    }
    
    function setPaused() public {
        paused = true;
    }
    
    function addToNum() public {
        require(paused == false, "Contract is paused");
        require(msg.sender == owner, "Not the owner");
        myNum++;
    }
   
     function sunFromNum() public {
        require(msg.sender == owner, "Not the owner");
        myNum--;
    }

}