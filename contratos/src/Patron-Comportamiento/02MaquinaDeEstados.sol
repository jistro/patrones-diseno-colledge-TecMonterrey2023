// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract MaquinaDeEstados {
    
    enum Estado { Inicial, Intermedio, Final }

    Estado s_estado;

    function transicionInicialAIntermedio() public returns (string memory, Estado) {
        if (s_estado != Estado.Inicial) {
            revert MaquinaDeEstados__EstadoInvalido();
        }
        s_estado = Estado.Intermedio;
        return ("Pasando de Inicial a Intermedio", s_estado);
    }

    function transicionIntermedioAFinal() public returns (string memory, Estado) {
        if (s_estado != Estado.Intermedio) {
            revert MaquinaDeEstados__EstadoInvalido();
        }
        s_estado = Estado.Final;
        return ("Pasando de Intermedio a Final", s_estado);
    }

    function verEstado() public view returns (Estado) {
        return s_estado;
    }

    error MaquinaDeEstados__EstadoInvalido();
}