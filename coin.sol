// SPDX-License-Identifier: GPL-3.0

//The contract allows only the creator to create new coin (different issuance schemes are possible)
//Anyone can send coins to each other without a need for registering with a username and password, all you need is an ethereum keypair

//TODO: Add more complexity

pragma solidity >=0.7.0 < 0.9.0;

contract Coin {

    //the keyword public it's making the variables
    //here accessible from other contracts
address public minter;
mapping(address => uint) public balances;

event Sent(address from, address to, uint amount);
//constructor only runs when we deploy the contract
constructor() {
    minter = msg.sender;
}

//make new coins and send them to an address
// only owner can send this coins
function mint(address receiver, uint amount) public {
   require(msg.sender == minter);
   balances[receiver] += amount;
}

error InsufficientBalance(uint requested, uint available);

//send any amount of coins
//to an existing address

function send(address receiver, uint amount) public {
    if(amount > balances[msg.sender] )
    revert InsufficientBalance({
        requested: amount, 
        available: balances[msg.sender]
        });

    balances[msg.sender] -= amount;
    balances[receiver] += amount;

    emit Sent(msg.sender,receiver,amount);
}
}