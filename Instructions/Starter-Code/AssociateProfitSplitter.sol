pragma solidity ^0.5.0;

// lvl 1: equal split
contract AssociateProfitSplitter {
    address payable employee_one = 0x37aA006CE907C828Ea4dc2c5319bafac58986957;
    address payable employee_two = 0x2C1699a59f87b14bF73d56eff31dAFb16d737829;
    address payable employee_three = 0x4268e7841A427E5A246eC9976Ff23AFa461e735c;
    
    
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // Split `msg.value` into three
        uint amount = msg.value/3;

        // Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);

        // Take care of a potential remainder by sending back to HR (`msg.sender`)
        msg.sender.transfer(msg.value - amount*3);
    }

    function() external payable {
        // Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}
