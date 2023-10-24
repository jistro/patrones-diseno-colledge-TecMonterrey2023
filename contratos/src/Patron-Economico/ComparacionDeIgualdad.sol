// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract Comparacion {
    function hashCompareWithLengthCheck(string memory a, string memory b) public pure returns (bool) {
        if (bytes(a).length != bytes(b).length) {
            return false;
        }
    }

    function hashCompareWithoutLengthCheck(string memory a, string memory b) public pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
