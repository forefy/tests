// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructWithMappingDeletion {
    
    struct User {
        uint256 balance;
        mapping(address => uint256) allowances;
    }

    mapping(address => User) public users;

    function addUser(address spender, uint256 allowance) public payable {
        require(msg.value > 0, "Must deposit some ETH");
        User storage user = users[msg.sender];
        user.balance += msg.value;
        user.allowances[spender] = allowance;
    }

    function deleteUser() public {
        // vuln -  The mapping within the struct is not properly cleaned up, leading to inconsistencies
        delete users[msg.sender]; 
    }

    function checkAllowance(address owner, address spender) public view returns (uint256) {
        return users[owner].allowances[spender];
    }
}