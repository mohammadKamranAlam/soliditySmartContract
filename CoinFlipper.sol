// Coin Flipper

pragma solidity ^0.4.0;
contract CoinFlipper {

    address creator;
    int lastgainloss;
    string lastresult;
    uint lastblocknumberused;
    bytes32 lastblockhashused;
    
    modifier isowner()
    {  
        require(msg.sender == creator);
        _;
    }
        
    

    function CoinFlipper()  payable
    {
        creator = msg.sender;                                 
        lastresult = "no wagers yet";
        lastgainloss = 0;
    }
    
    function sha(uint128 wager) constant public returns(uint256)  
    { 
        return uint256(sha3(block.difficulty, block.coinbase, now, lastblockhashused, wager));  
       
    }
    
    function betAndFlip() public payable          
    {
        if(msg.value > 340282366920938463463374607431768211455)      
        {
            lastresult = "wager too large";
            lastgainloss = 0;
            msg.sender.send(msg.value); // return wager
            return;
        }          
        else if((msg.value * 2) > this.balance)                     
        {
            lastresult = "wager larger than contract's ability to pay";
            lastgainloss = 0;
            msg.sender.send(msg.value); // return wager
            return;
        }
        else if (msg.value == 0)
        {
            lastresult = "wager was zero";
            lastgainloss = 0;
            // nothing wagered, nothing returned
            return;
        }
            
        uint128 wager = uint128(msg.value);                         
        
        lastblocknumberused = block.number - 1 ;
        lastblockhashused = block.blockhash(lastblocknumberused);
        uint128 lastblockhashused_uint = uint128(lastblockhashused) + wager;
        uint hashymchasherton = sha(lastblockhashused_uint);
        
        if( hashymchasherton % 2 == 0 )
           {
            lastgainloss = int(wager) * -1;
            lastresult = "loss";
            // they lost. Return nothing.
            return;
        }
        else
        {
            lastgainloss = wager;
            lastresult = "win";
            msg.sender.send(wager * 2);  // They won. Return bet and winnings.
        }         
    }
    
      function getLastBlockNumberUsed() constant returns (uint)
    {
        return lastblocknumberused;
    }
    
    function getLastBlockHashUsed() constant returns (bytes32)
    {
        return lastblockhashused;
    }

    function getResultOfLastFlip() constant returns (string)
    {
        return lastresult;
    }
    
    function getPlayerGainLossOnLastFlip() constant returns (int)
    {
        return lastgainloss;
    }
        
    function getContractBalance() constant returns (uint)
    {
        return this.balance;
    }
    
    function kill() isowner
    { 
                    suicide(creator);  
           
    }
}
