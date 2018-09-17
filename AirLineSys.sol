//Airline

pragma solidity ^0.4.0;
contract airline
{
    address public creator;
    uint public starttime;
    uint public endtime;
    string public bookresult;
    string public withdrawresult;
    uint public random_number;
     mapping(address =>passenger)public passengerlist;
     struct Flight
     {
        string name;
        uint capacity;
        uint durationtime;
        uint price;
        uint count;
}
struct passenger{
    uint amount;
    uint no;
    uint pnrno;
}
Flight[] public flight;
function airline() payable public 
{
  creator=msg.sender;
  random_number=100;
   bookresult="Flight Booking Incomplete";
   withdrawresult="Flight WithDraw Incomplete";
  flight.push(Flight("Dubai",10,3* 1 hours,10 ,0));
  flight.push(Flight("England",10,2* 1 hours,10,0));
   flight.push(Flight("Australia",10,2* 1 hours,10,0));
  starttime=now;
  endtime=now+(10 * 1 minutes);
}
function getPrice(uint ch) public  returns (uint)
{
    if(ch<=2)
    return flight[ch].price*1 ether;
    else
    return 0;
}
function bookflight(uint ch,uint n) public payable 
{
// require(msg.sender!=creator);
// require(now<endtime);
 bookresult="Flight Booking UnScuccessfull";
 if(ch<=2)
 {
    // require(flight[ch].count<flight[ch].capacity);
     //require(msg.value>=flight[ch].price*n*1 ether);
     if(msg.value>=flight[ch].price*n*1 ether)
     {
         passengerlist[msg.sender].no+=n;
         msg.sender.transfer(msg.value-(flight[ch].price *n*1 ether));
         passengerlist[msg.sender].amount=msg.value;
         random_number++;
         passengerlist[msg.sender].pnrno=random_number;
     }
     flight[ch].count+=n;
     bookresult="Flight Booking Successfull";
 }
/* else if(ch==1)
 {
     require(flight[1].count<flight[1].capacity);
     require(msg.value>=flight[1].price *1 ether);
     if(msg.value>=flight[1].price* 1 ether)
     {
         msg.sender.send(msg.value-(flight[1].price * 1 ether));
     }
     passengerlist[msg.sender].amount+=msg.value;
     flight[1].count++;
     bookresult="Flight Booking Successfull";
 }
 else 
 {
     require(flight[2].count<flight[2].capacity);
     require(msg.value>=flight[2].price *1 ether);
     if(msg.value>=flight[2].price* 1 ether)
     {
         msg.sender.send(msg.value-(flight[2].price * 1 ether));
     }
     passengerlist[msg.sender].amount+=msg.value;
     flight[2].count++;
     bookresult="Flight Booking Successfull";
 }*/
 
}
function withdraw(uint ch,uint pno) payable public
{
 // require(msg.sender!=creator);  
  //require(now<endtime);
  require(passengerlist[msg.sender].amount>0&&passengerlist[msg.sender].pnrno==pno);
  withdrawresult="Flight WithDraw UnScuccessfull";
  if(ch<=2)
  {  
      uint n=passengerlist[msg.sender].no;
      msg.sender.transfer(flight[ch].price*1 ether*n);
      passengerlist[msg.sender].amount=0;
      //this.balance-flight[ch].price*1 ether*n;
      flight[ch].count-=n;
      passengerlist[msg.sender].no=0;
      passengerlist[msg.sender].pnrno=0;
      withdrawresult="Flight WithDraw Successfull";
      
  }

}
function getBalance()public  returns (uint)
{
    return this.balance;
}
function get_available_tickets(uint ch) public  returns(uint) 
{
    
        if(ch<=2)
       { return flight[ch].capacity-flight[ch].count;}
       else
       return 0;

}
function getbookresult() public  returns(string)
{
    return bookresult;
}
function getwithdrawresult() public  returns(string)
{
    return withdrawresult;
}
function kill() public
{
    require(now>=endtime);
    require(msg.sender==creator);
        selfdestruct(creator);
    
}
function get_pnr_no() public  returns(uint)
{
   // require(msg.sender!=creator);
    require(now<endtime);
   require(passengerlist[msg.sender].amount!=0);
   return (passengerlist[msg.sender].pnrno);

}
}
