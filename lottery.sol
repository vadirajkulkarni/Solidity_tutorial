pragma solidity >=0.8.0;

contract Lottery{
    address public owner;
    uint8 public lotteryNumber;
    address[] public winnersList;
    address[] public participants;
    uint8[] public lotteryNumbers;
    mapping(address => uint8) public lotteryHolders;
    uint8 public count = 0;
    uint256 totalPot = 0;
    //uint private i = 0;
    uint8 public lotteryWinNumber = 0;
    
    
    constructor() public {
        owner = msg.sender;
        count = 0;
    }
    
    
    
    function enter() public payable returns(uint8 number){
        require(msg.value == 1 ether, "Error, less amount");
        participants.push(msg.sender);
        totalPot = totalPot + msg.value;
        uint8 _number = returnRandom();
        lotteryNumbers.push(_number);
        return  _number;
    }
    
    function returnRandom() private view returns(uint8){
        
        return 5;
    }
    
    
    function drawLottery() public returns(uint8){
        require(owner == msg.sender, "Error, Not authorised");
        lotteryWinNumber = 5;
        return lotteryWinNumber;
    }
    
    function numberOfLotteryWinners() public returns(uint8){
        require(lotteryWinNumber > 0, "Error, Lottery hasnt drawn yet");
        require(participants.length > 0, "Error, no one has participated");
        for(uint i=0; i<participants.length ; i++){
            if(lotteryNumbers[i] == lotteryWinNumber){
                winnersList.push(participants[i]); 
                count++;
            }
        }
        
        return uint8(winnersList.length);
    }
    
    function payTheWinners() public payable {
        require(owner == msg.sender, "Error, Not authorised");
        uint256 payPerHead = totalPot/winnersList.length;
        for(uint i=0; i < winnersList.length ; i++ ){
            
            transfer(payable(winnersList[i]), payPerHead);
        }
    }
    
    function transfer(address payable reciever, uint256 _value) public  payable{
        require(msg.sender == owner, "Error, Not authorised");
        reciever.transfer(_value);
    }
 }