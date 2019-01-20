contract Auction{
    
    address auctionOwner;
    uint incrementBid;
    address highestBidder;
    uint highestBid;
    uint highestBindingBid;
    mapping(address=>uint256) fundOfBidder;
    
    /*constructor to initialize the owner and the bid increment 
    value if the address of the auction owner is filled, i.e not 0*/
    function Auction(address _auctionOwner, uint _incrementBid ,uint minBid){
        require(_auctionOwner!=0 );
        auctionOwner = _auctionOwner;
        incrementBid = _incrementBid;
        highestBindingBid = incrementBid;
        highestBidder = auctionOwner;
    }
    
    //allows user to place bids
    function placeBid() public returns (bool success){
        require(msg.sender!=auctionOwner);
        require(msg.value != 0);
        uint newBid = fundOfBidder[msg.sender]+msg.value;
        if(newBid<highestBindingBid){
            revert();
        }
        highestBid = fundOfBidder[highestBidder];
        fundOfBidder[msg.sender] = newBid;
        if(newBid <= highestBid){
            if(newBid+incrementBid>highestBid){
                highestBindingBid = highestBid;
            }
            else{
                highestBindingBid = newBid+incrementBid;
            }
        }
        else{
            if(msg.sender == highestBidder){
                highestBid = newBid;
            }
            else{
                highestBidder = msg.sender;
            if(newBid+incrementBid>highestBid){
                highestBindingBid = highestBid;
            }
            else{
                highestBindingBid = newBid+incrementBid;
            }
            highestBid = newBid;
            }
        }
        return true;
    }
    
    /*allows owner to withdraw fund from the contract after
    the aucton is finished*/
    function withdrawFund() public returns (bool success){
        
    }
    /*allows owner to cancel the auction in any case of emergency*/
    function cancelAuction() public returns (bool success){
        
    }
}
