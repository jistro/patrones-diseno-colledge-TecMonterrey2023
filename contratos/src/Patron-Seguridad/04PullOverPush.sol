// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract PullOverPush {

    error PullOverPush__FondosInsuficientes();
    error PullOverPush__CantidadCero();
    mapping (address => uint256) s_cuentas;

    receive() external payable {
        depositar();
    }
    fallback() external payable {
        depositar();
    }
    function depositar() public payable {
        s_cuentas[msg.sender] += msg.value;
    }
    

    function retirar(uint256 cantidad) public {
        if (cantidad == 0) {
            revert PullOverPush__CantidadCero();
        }
        if (cantidad > s_cuentas[msg.sender]) {
            revert PullOverPush__FondosInsuficientes();
        }
        s_cuentas[msg.sender] -= cantidad;
        payable(msg.sender).transfer(cantidad);
    }
    
}