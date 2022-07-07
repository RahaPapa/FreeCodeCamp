//SPDCX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory {
SimpleStorage[] public simpleStorageArray;

function createSimpleStorageContract() public {
    //How does storage factory know what simple storage looks like?
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

function sfStore(uint256 _simpleSimpleIndex, uint256 _simpleStorageNumber) public {
//aadress 
//ABI - Application binary interface
simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
}

function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
    return SimpleStorageArray[_simpleStorageIndex].retrieve();
}
}
