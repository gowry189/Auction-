contract Auction{
    
    address auctionOwner;
    uint incrementBid;
    address highestBidder;
    uint highestBid;
    uint bindingBid;
    //allows user to place bids
    function placeBid() public returns (bool success){
        
    }
    /*allows owner to withdraw fund from the contract after
    the aucton is finished*/
    function withdrawFund() public returns (bool success){
        
    }
    /*allows owner to cancel the auction in any case of emergency*/
    function cancelAuction() public returns (bool success){
        
    }
}
