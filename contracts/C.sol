//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract C {
    constructor() {
        console.log("Deploying C at address:", address(this));
    }

    function c() payable external {
        console.log("C.c: msg.sender =", msg.sender);
        console.log("C.C: msg.value =", msg.value);
    }

    function callC() payable external {
        console.log("C.callC: msg.sender =", msg.sender);
        console.log("C.callC: msg.value =", msg.value);
    }

    function delegatecallC() payable external {
        console.log("C.delegatecallC: msg.sender =", msg.sender);
        console.log("C.delegatecallC: msg.value =", msg.value);
    }
}
