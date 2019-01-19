contract Auction{
    
    address auctionOwner;
    uint incrementBid;
    address highestBidder;
    uint highestBid;
    uint bindingBid;
    
    /*constructor to initialize the owner and the bid increment 
    value if the address of the auction owner is filled, i.e not 0*/
    function Auction(address _auctionOwner, uint _incrementBid){
        require(_auctionOwner!=0 );
        auctionOwner = _auctionOwner;
        incrementBid = _incrementBid;
    }
    
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
