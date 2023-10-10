// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract TransferenciaSeguraETH {
    error TransferenciaSeguraETH__FondosInsuficientes();
    error TransferenciaSeguraETH__TransferenciaFallida();

    function transferirETH(address payable _destinatario, uint256 _cantidad) public {
        uint256 balance = address(this).balance;
        if (balance < _cantidad) {
            revert TransferenciaSeguraETH__FondosInsuficientes();
        }
        (bool success, ) = _destinatario.call{value: _cantidad}("");
        if (!success) {
            revert TransferenciaSeguraETH__TransferenciaFallida();
        }
    }

    receive() external payable {
        // Esta función permite recibir ETH en el contrato
    }

    function consultarBalanceContrato() public view returns (uint256) {
        return address(this).balance;
    }
}