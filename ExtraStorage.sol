//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

function getPrice() internal view returns (uint256) {
//ABI 
//Address 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 // ETH / USD address https://docs.chain.link/docs/ethereum-addresses/
   AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    (,int256 price,,,) = priceFeed.latestRoundData();
    //ETH in terms of USD
    //3000.00000000
    return uin256(price * 1e10); // 1**10 == 10000000000
    }

function getVersion() public view returns (uint256) {
AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
return priceFeed.version();
}

function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
    uint256 ethPrice = getPrice();
    //3000_0000000000000000000(18nulli) wei units = ETH / USD price
    //1_00000000000000000000 ETH
    uint256 ethAmountInUsd = (ethPrice = ethAmount) / 1e18; //Always multiple before divide 
return ethAmountInUsd;

}

}
