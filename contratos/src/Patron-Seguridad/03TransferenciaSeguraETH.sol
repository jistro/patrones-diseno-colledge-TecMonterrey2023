// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract TransferenciaSeguraETH {
    error TransferenciaSeguraETH__FondosInsuficientes();
    error TransferenciaSeguraETH__TransferenciaFallida();

    function transferirETHporSend(address payable _destinatario, uint256 _cantidad) public {
        if (address(this).balance < _cantidad) {
            revert TransferenciaSeguraETH__FondosInsuficientes();
        }
        if (!_destinatario.send(_cantidad)) {
            revert TransferenciaSeguraETH__TransferenciaFallida();
        }
    }

    function transferirETHporCallValue(address payable _destinatario, uint256 _cantidad) public {
        if (address(this).balance < _cantidad) {
            revert TransferenciaSeguraETH__FondosInsuficientes();
        }
        (bool exito, ) = _destinatario.call{value: _cantidad}("");
        if (!exito) {
            revert TransferenciaSeguraETH__TransferenciaFallida();
        }
    }

    function transferirETHporTransfer(address payable _destinatario, uint256 _cantidad) public {
        if (address(this).balance < _cantidad) {
            revert TransferenciaSeguraETH__FondosInsuficientes();
        }
        _destinatario.transfer(_cantidad);
    }

    receive() external payable {
        // Esta función permite recibir ETH en el contrato
    }

    function consultarBalanceContrato() public view returns (uint256) {
        return address(this).balance;
    }
}