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
        mapping(address => bool) blacklisted;
        bool public auctionFinalized;
        constructor() {
            owner = msg.sender;
        }
        modifier onlyOwner(){
            require(msg.sender==owner, "You are not an owner.");
            _;
        }

        function addToBlacklist(address _bidder) public onlyOwner{
            require(blacklisted[_bidder]==false, "The bidder is already blacklisted");
            blacklisted[_bidder]=true;
        }

        function removeFromBlacklist(address _bidder) public onlyOwner{
            require(blacklisted[_bidder], "The bidder is not in the blacklist");
            blacklisted[_bidder]=false;
        }

        function startAuction(uint _startingPrice, uint _duration) public onlyOwner {
            require(_startingPrice!=0, "Starting Price cannot be zero.");
            require(_duration!=0, "Duration of the auction cannot be zero.");
            startingPrice = _startingPrice;
            starting_Time = block.timestamp;
            endingTime = starting_Time + _duration;
            lastBid = _startingPrice;
            auctionFinalized = false;
        }
        function bid() public payable {
            require(msg.value>lastBid,"Bid needs to be bigger than last bid");
            require(block.timestamp<endingTime, "Auction has ended");
            require(blacklisted[msg.sender]==false,"You are blacklisted and cannot bid.");
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
        function finalizeAuction() public payable onlyOwner returns (address,uint){
            require(auctionFinalized==false, "Auction is already finalized");
            require(block.timestamp>endingTime, "Auction is still going on.");
            if(lastBid==startingPrice){
                auctionFinalized = true;
                return(msg.sender,startingPrice);
            }
            auctionFinalized = true;
            bids[highestBidder]-=lastBid;
            payable(owner).transfer(lastBid);
            return (highestBidder,lastBid);
        }

    }