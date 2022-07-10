//Get funds from users 
//Withraw funds
//Set a minimum funding value in USD

//SPDX-License-Idendifier: MIT 
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

//132150 gas. Constant and immutable to pring gas down

error NotOwner();

contract FundMe {
using PriceConverter for uint256;

uint256 public constant MINIMUM_USD = 50 * 1e18; // 1 * 10 **18

address[] public funders;
mapping(address => uint256) public addressToAmountFunded;


address public immutable i_owner;

constructor(){
i_owner = msg.sender;
}

function fund() public payable {
//want to be able to set a minimum fund amount 
//1. How to we send ETH to this contract?
require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!"); // 1e18 = 1 * 10 **18 kümme astmes kaheksateist wei-d
// 18 decimal places is amount in wei
//What is reverting? Undo any action before, and send remaining gas back

addressToAmountFunded[msg.sender] += msg.value;
funders.push(msg.sender); 
}

modifier onlyOwner {
    _;
//    require(msg.sender == i_owner, "Sender is not owner!");
if(msg.sender != i_owner) { revert NotOwner(); }
_;
}

function withdraw() payable onlyOwner public {
    /*starting index, ending index, step amount */
    for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
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

//what happens if someone sends this contract ETH without calling fund function
receive () external payable {
fund();
}

fallback () external payable {
fund();
}
}
 // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()
