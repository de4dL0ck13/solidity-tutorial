pragma solidity ^0.4.11;

contract EtherBank {
    address public owner;
    
    mapping (address => uint) private balances;
    
    event DepositComplete(address account, uint amount);
    
    function CoolBank() public {
        owner = msg.sender;
    }
    
    function deposit(address account) public payable returns (uint) {
        balances[account] += msg.value;
        
        DepositComplete(account, msg.value);
        
        return balances[account];
    }
    
    function withdraw(uint amount) public returns (uint) {
        require(balances[msg.sender] >= amount);
        
        balances[msg.sender] -= amount;
        if (!msg.sender.send(amount)) {
            balances[msg.sender] += amount;
        }
        
        return balances[msg.sender];
    }
}
