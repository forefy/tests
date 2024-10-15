// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract UnsafeMintContract is ERC721 {
    uint256 public tokenCounter;

    constructor() ERC721("UnsafeMint", "UMT") {
        tokenCounter = 0;
    }

    // vuln - _mint
    function mint(address recipient) public {
        _mint(recipient, tokenCounter);
        tokenCounter++;
    }
}
