pragma solidity ^0.4.2;

contract Counter {
    address owner;
    address factory;
    uint counter = 0;
    
    modifier isOwner(address _owner) {
        require(msg.sender == factory);
        require(owner == _owner);
        _;
    }
    
    function Counter(address _owner) public {
        owner = _owner;    
        factory = msg.sender;
    }
    
    function increment(address _caller) isOwner(_caller) public {
        counter++;
    }
    
    function getCounter() constant public returns(uint) {
        return counter;
    }
}

contract CounterFactory {
    mapping (address => address) counters;
    
    function createCounter() public {
        if (counters[msg.sender] == 0) {
            counters[msg.sender] = new Counter(msg.sender);
        }
    }
    
    function increment() public {
        require(counters[msg.sender] != 0x0);
        Counter(counters[msg.sender]).increment(msg.sender);
    }
    
    function getCounter() public constant returns(uint) {
        require(counters[msg.sender] != 0x0);
        return Counter(counters[msg.sender]).getCounter();
    }
}
