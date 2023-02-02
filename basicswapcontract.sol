pragma solidity >=0.5.0 <0.8.0;

contract Swap {
    mapping(address => uint) public balances;

    function deposit(uint amount) public payable {
        require(msg.value == amount, "Incorrect deposit amount");
        balances[msg.sender] += amount;
    }

    function swap(address recipient, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient funds");
        require(recipient.send(amount), "Transaction failed");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient funds");
        msg.sender.transfer(amount);
        balances[msg.sender] -= amount;
    }
}
