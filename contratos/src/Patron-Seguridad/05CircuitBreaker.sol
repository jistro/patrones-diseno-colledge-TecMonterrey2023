// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract CircuitBreaker {
    error CircuitBreaker__FondosInsuficientes();
    error CircuitBreaker__CantidadCero();
    error CircuitBreaker__NoAutorizado();
    error CircuitBreaker__ContratoInactivo();

    bool private breakCircuit = false;

    address immutable owner;

    mapping(address => uint256) s_cuentas;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert CircuitBreaker__NoAutorizado();
        }
        _;
    }

    modifier onlyActive() {
        if (breakCircuit) {
            revert CircuitBreaker__ContratoInactivo();
        }
        _;
    }

    receive() external payable onlyActive {
        depositar();
    }

    fallback() external payable onlyActive {
        depositar();
    }

    function depositar() public payable onlyActive {
        s_cuentas[msg.sender] += msg.value;
    }

    function cambiarEstadoCircuito() public onlyOwner {
        breakCircuit = !breakCircuit;
    }

    function retirar(uint256 cantidad) public onlyActive {
        if (cantidad == 0) {
            revert CircuitBreaker__CantidadCero();
        }
        if (cantidad > s_cuentas[msg.sender]) {
            revert CircuitBreaker__FondosInsuficientes();
        }
        s_cuentas[msg.sender] -= cantidad;
        payable(msg.sender).transfer(cantidad);
    }
}
