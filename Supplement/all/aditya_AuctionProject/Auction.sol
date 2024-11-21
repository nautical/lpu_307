    pragma solidity ^0.8.0;
    // SPDX-License-Identifier: MIT

    contract Auction{
        address public owner;
        uint public startingPrice;
        uint public starting_Time;
        uint public endingTime;
        uint public lastBid;
        address public highestBidder;
        mapping(address => uint) bids;
        bool public auctionFinalized;
        constructor() {
            owner = msg.sender;
        }
        modifier onlyOwner(){
            require(msg.sender==owner, "You are not an owner.");
            _;
        }
        function startAuction(uint _startingPrice, uint _duration) public onlyOwner {
            startingPrice = _startingPrice;
            starting_Time = block.timestamp;
            endingTime = starting_Time + _duration;
            lastBid = _startingPrice;
            auctionFinalized = false;
        }
        function bid() public payable {
            require(msg.value>lastBid,"Bid needs to be bigger than last bid");
            require(block.timestamp<endingTime, "Auction has ended");
            bids[msg.sender] +=msg.value;
            lastBid = msg.value;
            highestBidder = msg.sender;
        }
        function withdraw() public payable {
            require(auctionFinalized, "Auction has not been finalized yet...");
            uint amount = bids[msg.sender];
            bids[msg.sender] = 0;
            payable(msg.sender).transfer(amount);
        }
        function finalizeAuction() public onlyOwner returns (address,uint){
            require(block.timestamp>endingTime, "Auction is still going on.");
            if(lastBid==startingPrice){
                auctionFinalized = true;
                return(msg.sender,startingPrice);
            }
            auctionFinalized = true;
            bids[highestBidder]-=lastBid;
            return (highestBidder,lastBid);
        }
        function time() public view returns(uint){
            return block.timestamp;
        }
        function et() public view returns(uint){
            return endingTime;
        }

    }