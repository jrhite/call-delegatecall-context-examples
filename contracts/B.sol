//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./C.sol";

contract B {
    address private c;

    constructor(address _c) {
        c = _c;
        console.log("Deploying B at address:", address(this));
    }

    function b() payable external {
        console.log("B.b: msg.sender =", msg.sender);
        console.log("B.b: msg.value =", msg.value);

        //C(c).c{ value: msg.value / 2 }();
        C(c).c();
    }

    function callB() payable external {
        console.log("B.callB: msg.sender =", msg.sender);
        console.log("B.callB: msg.value =", msg.value);

        //(bool success, ) =  address(c).call{ value: msg.value / 2 }(abi.encodeWithSignature("callC()"));
        // require(success, "Failure in address(c).call{ value: msg.value / 2 }(abi.encodeWithSignature(\"callC()\"))");

        (bool success, ) = address(c).call(abi.encodeWithSignature("callC()")); 
        require(success, "Failure in address(b).call(abi.encodeWithSignature(\"callC()\"))");
    }

    function delegatecallB() payable external {
        console.log("B.delegatecallB: msg.sender =", msg.sender);
        console.log("B.delegatecallB: msg.value =", msg.value);
        
        // this code won't compile because you cannot set the option 'value' for delegatecalls
        // (bool success, ) = address(c).delegatecall{ value: msg.value / 2 }(abi.encodeWithSignature("delegatecallC()"));
        // require(success, "Failure in address(c).delegatecall{ value: msg.value / 2 }(abi.encodeWithSignature(\"delegatecallC()\"))");

        (bool success, bytes memory result) = address(c).delegatecall(abi.encodeWithSignature("delegatecallC()"));
        // console.log("B.delegatecallB: success =", success);
        // console.log("B.delegatecallB: result =", abi.decode(result, ...));
        require(success, "Failure in address(c).delegatecall(abi.encodeWithSignature(\"delegatecallC()\"))");
    }

    function privateB() view private {
        console.log("B.privateB: msg.sender =", msg.sender);
    }
}
