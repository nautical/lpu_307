// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedAuction {
    // State Variables
    address public owner; // Owner of the contract
    uint256 public auctionEndTime; // Auction end timestamp
    string public itemName; // Name of the item being auctioned
    uint256 public startingPrice; // Starting price of the auction
    bool public isAuctionActive; // Indicates if the auction is active

    address public highestBidder; // Address of the highest bidder
    uint256 public highestBid; // Amount of the highest bid

    mapping(address => uint256) public pendingReturns; // Tracks refunds for non-winning bidders

    // Constructor
    constructor() {
        owner = msg.sender; 
    }

    // Modifier: Restrict function access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner,"Not authorized!");
        _;
    }

     // Function to start an auction
    function startAuction(string memory _itemName, uint256 _startingPrice, uint256 _duration) public onlyOwner {
        itemName = _itemName;
        startingPrice = _startingPrice;
        auctionEndTime = block.timestamp + _duration;
        isAuctionActive = true;
        highestBid = 0;
    }

    // Function to place a bid
    function bid() public payable {
        require(isAuctionActive, "Auction is not active");
        require(!hasAuctionEnded() ,"Auction is Ended");

        if ( msg.value > highestBid ){
            pendingReturns[highestBidder] = highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;
        
    }

    // Function to withdraw unsuccessful bid amounts
    function withdraw() public {
        require(hasAuctionEnded() ,"Auction is not Ended yet!");
        uint amount = pendingReturns[msg.sender];
        pendingReturns[msg.sender] = 0;

        payable(msg.sender).transfer(amount);

    }

    // Function to finalize the auction
    function finalizeAuction() public onlyOwner {
        require(hasAuctionEnded() , "Auctions is not ended yet");
        isAuctionActive = false;
        payable(owner).transfer(highestBid);
        highestBid = 0;
        
    }

    // View function to check if the auction has ended
    function hasAuctionEnded() public view returns (bool) {
        // Return whether the auction duration has elapsed
        return block.timestamp >= auctionEndTime;
    }
}