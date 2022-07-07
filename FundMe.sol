//Get funds from users 
//Withraw funds
//Set a minimum funding value in USD

//SPDX-License-Idendifier: MIT 
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
using PriceConverter for uint256;

uint256 public minimumUsd = 50 * 1e18; // 1 * 10 **18

address[] public funders;
mapping(address => uint256) public addressToAmountFunded;

address public owner;

constructor(){
owner = msg.sender;
}

function fund() public payable {
msg.value.getConversionRate();

//want to be able to set a minimum fund amount 
//1. How to we send ETH to this contract?
require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough!"); // 1e18 = 1 * 10 **18 kümme astmes kaheksateist wei-d
// 18 decimal places is amount in wei
//What is reverting? Undo any action before, and send remaining gas back
funders.push(msg.sender); 
addressToAmountFunded(msg.sender) = msg.value;
}

function withdraw() public onlyOwner {
    require (msg.sender == owner, "Sender is not owner!");
    /*starting index, ending index, step amount */
    for(uint256 funderIndex = 0, funderIndex < funders.length; funderIndex++){
address funder = funders[fundersIndex];
aadressToAmountfunded[funder] = 0;
    }
//reset the array
funders = new address[](0);
//actually withdraw the funds

// for loop
//[1, 2, 3, 4]
// 0. 1. 2. 3.

//call
//msg.sender = address
//payable(msg.sender) = payable aadress

//transfer
//payable(msg.sender).transfer(address(this).balance);

//send
//bool sendSuccess = payable(msg.sender).send(address(this).balance);
//require(sendSuccess, "send failed");
//call
(bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
require(callSuccess, "Call failed");
}

modifier onlyOwner {
    _;
    require(msg.sender == owner, "Sender is not owner!");

}

}
