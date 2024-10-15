// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NoZeroAddressCheck {
    address public owner;
    address public admin;
    bool public initialized;

    // Implements 0 address check
    constructor(address initialOwner) {
        require(initialOwner != address(0), "Owner cannot be the zero address");
        owner = initialOwner;
        initialized = false;
    }

    // vuln - no 0 address check
    function init(address adminAddress) public {
        admin = adminAddress;
        initialized = true;
    }

    // Implements 0 address check
    function setOwner(address newOwner) public {
        require(newOwner != address(0), "New owner cannot be the zero address");
        owner = newOwner;
    }

    // Doesn't need 0 address check
    function doSomething(address newOwner) public view returns (string memory) {
        return "This function does something!";
    }
}