pragma solidity ^0.8.0;

contract Escrow {
    address payable public buyer;
    address payable public seller;
    uint public amount;
    bool public isReleased;
    bool public workCompleted;
    uint public deadline;

    constructor(address payable _buyer, address payable _seller, uint _amount) {
        buyer = _buyer;
        seller = _seller;
        amount = _amount;
        isReleased = false;
        workCompleted = false;
    }

    function deposit() public payable {
        require(msg.sender == buyer && !isReleased, "Deposit not allowed");
        require(msg.value == amount, "Incorrect deposit amount");
    }

    function markWorkCompleted() public {
        require(msg.sender == buyer && !isReleased, "Marking work completed is not allowed");
        workCompleted = true;
    }

    function release() public {
        require(msg.sender == seller && !isReleased && workCompleted, "Release not allowed");
        isReleased = true;
        seller.transfer(amount);
    }

    function refund() public {
        require(msg.sender == buyer && !isReleased, "Refund not allowed");
        isReleased = true;
        buyer.transfer(amount);
    }
}

