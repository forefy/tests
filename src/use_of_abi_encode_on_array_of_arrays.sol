// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayEncoding {
    uint[2][3] multiDimensionalArray = [[1, 2], [3, 4], [5, 6]];
    uint[] public simpleArray = [1, 2, 3, 4, 5, 6];

    // vuln - Encoding multi-dimensional array may be parsed differently on some Solidity versions
    function encodeMultiDimensionalArray() public {                                                                                          
        bytes memory encodedData = abi.encode(multiDimensionalArray);
    }

    // Regular one-dimensional array should be ok
    function encodeSimpleArray() public {                                                                                          
        bytes memory encodedData = abi.encode(simpleArray);
    }
}
