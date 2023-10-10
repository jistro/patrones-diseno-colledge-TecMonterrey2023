// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract VerEfectInteracciones is ReentrancyGuard{
    event InteraccionExitosa(address direccion, string mensaje);

    function interactuar() public  nonReentrant returns(string memory){
        return "You shall not reentry";
    }
}