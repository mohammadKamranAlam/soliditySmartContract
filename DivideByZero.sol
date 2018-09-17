// Divide by Zero


pragma solidity ^0.4.4;

contract MyContract  {
    uint dividend;
    uint divisor;
    uint  public result;

   //a/b b>0
    
    modifier checkDivisorZero() { // Modifier //before functions and after variables
        if(divisor == 0){
            throw;
        } _;
    }
    modifier checkDivident(){
        if(dividend > 4)
        _;
        
        else{
        throw;
        }
    
    }
    
    function setdividendDivisor(uint a,uint b) checkDivident {
        dividend=a;
        divisor=b;
    }
    function getResult() constant returns (uint){
        return result;
    }
    function getdivident() constant public returns (uint){
        return dividend;
    }
    
    function divide() checkDivisorZero  public returns (bool) { 
        
        //require(divisor !=0);
        result=dividend/divisor;
        return true;
        
    }
}
