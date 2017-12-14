pragma solidity ^0.4.18;

/// @title EtherBank
/// @author De4dL0ck13

contract EtherBank {
    // owner will be able to destroy contract
    address public owner;
    
    //dictionary mapping addresses to balances
    mapping (address => uint) private balances;
    
    //event confirming deposit
    event DepositComplete(address account, uint amount);
    
    function EtherBank() public {
        owner = msg.sender;
    }
    
    function deposit(address account) public payable returns (uint) {
        balances[account] += msg.value;
        
        DepositComplete(account, msg.value); //fire event
        
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

    function balance(address customer) public constant returns (uint){
      return balances[customer];
    }

    function remove() public {
      if (msg.sender == owner) {
        selfdestruct(owner);
      }
    }
}
