// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleFundraising {
    address payable public owner;          // The address of the contract owner
    uint256 public totalFunds;             // Total amount of funds raised
    uint256 public fundraisingEnd;         // Timestamp for when fundraising ends

    // Constructor
    constructor() {
        // TODO: Initialize the owner to the contract deployer
        // TODO: Set totalFunds to 0
        // TODO: Set fundraisingEnd to the current block timestamp plus 1 week
    }

    // Modifier to restrict access to only the contract owner
    modifier onlyOwner() {
        // TODO: Implement the require statement to check if msg.sender is the owner
        _;
    }

    // Modifier to check if the fundraising is still active
    modifier fundraisingActive() {
        // TODO: Implement the require statement to check if the current time is less than fundraisingEnd
        _;
    }

    // Function to donate Ether to the contract
    function donate() public payable fundraisingActive {
        // TODO: Update totalFunds with the amount donated (msg.value)
    }

    // Function for the owner to withdraw the total funds after fundraising ends
    function withdraw() public onlyOwner {
        // TODO: Implement the require statement to check if the current time is greater than or equal to fundraisingEnd
        // TODO: Store the total funds in a local variable
        // TODO: Reset totalFunds to 0 before transferring
        // TODO: Transfer the funds to the owner
    }
}
