//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./B.sol";

contract A {
    address private b;

    constructor(address _b) {
        b = _b;
        console.log("Deploying A at address:", address(this));
    }

    function a() payable external {
        console.log("A.a: msg.sender =", msg.sender);
        console.log("A.a: msg.value =", msg.value);

        B(b).b{ value: msg.value / 2 }();
        //B(b).b();
    }

    function callA() payable external {
        console.log("A.callA: msg.sender =", msg.sender);
        console.log("A.callA: msg.value =", msg.value);
        
        (bool success, ) =  address(b).call{ value: msg.value / 2 }(abi.encodeWithSignature("callB()"));
        require(success, "Failure in address(b).call{ value: msg.value / 2 }(abi.encodeWithSignature(\"callB()\"))");

        // (bool success, ) = address(b).call(abi.encodeWithSignature("callB()")); 
        // require(success, "Failure in address(b).call(abi.encodeWithSignature(\"callB()\"))");
    }

    function delegatecallA() payable external {
        console.log("A.delegatecallA: msg.sender =", msg.sender);
        console.log("A.delegatecallA: msg.value =", msg.value);
        
        // this code won't compile because you cannot set the option 'value' for delegatecalls
        // (bool success, ) =  address(b).delegatecall{ value: msg.value / 2 }(abi.encodeWithSignature("delegatecallB()"));
        // require(success, "Failure in address(b).deledgatecall{ value: msg.value / 2 }(abi.encodeWithSignature(\"delegatecallB()\"))");

        (bool success, ) = address(b).delegatecall(abi.encodeWithSignature("delegatecallB()")); 
        require(success, "Failure in address(b).delegatecall(abi.encodeWithSignature(\"delegatecallB()\"))");
    }

    function privateA() payable external {
        console.log("A.privateA: msg.sender =", msg.sender);
        console.log("A.privateA: msg.value =", msg.value);
        
        // this will fail, because `address.call(...)` respects Solidity function visibility types
        (bool success, ) =  address(b).call{ value: msg.value / 2 }(abi.encodeWithSignature("privateB()"));
        assert(!success);

        // this will fail, because `address.call(...)` respects Solidity function visibility types
        // (bool success, ) = address(b).call(abi.encodeWithSignature("privateB()")); 
        // require(success, "Failure in address(b).call(abi.encodeWithSignature(\"privateB()\"))");
    }
}
