contract Auction{
    
    address auctionOwner;
    uint incrementBid;
    address highestBidder;
    uint highestBid;
    uint highestBindingBid;
    mapping(address=>uint256) fundOfBidder;
    
    event LogPlaceBid(uint highestBid, address highestBidder, uint highestBindingBid);
    
    /*constructor to initialize the owner and the bid increment 
    value if the address of the auction owner is filled, i.e not 0*/
    
    
    //allows user to place bids
    function placeBid() public payable returns (bool success){
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
    
    
    function withdrawFund() public payable returns (bool success){
        address withdrawFrom;
        uint withdrawalAmount;
        bool flag;
        
        /*allows the owner of the auction to withdraw the funds in the contract
        from the highest bidder*/
        if(msg.sender == auctionOwner){
            withdrawFrom= highestBidder;
            withdrawalAmount = highestBindingBid;
            flag = true;
        }
        
        
        /*allows the auction winner(highest bidder) to withdraw the exxess amount
        from the contract*/
        else if(msg.sender == highestBidder){
            withdrawFrom = msg.sender;
            if(flag){
                withdrawalAmount = fundOfBidder[highestBidder];
            }
            else{
                withdrawalAmount = fundOfBidder[highestBidder]-highestBindingBid;
            }
        }
        
        else{
            withdrawFrom = msg.sender;
            withdrawalAmount = fundOfBidder[msg.sender];
        }
        require(withdrawalAmount != 0);
        fundOfBidder[withdrawFrom] = -withdrawalAmount;
        require(msg.sender.send(withdrawalAmount));
        return true;
    }
    /*allows owner to cancel the auction in any case of emergency*/
    function cancelAuction() public returns (bool success){
        
    }
}
