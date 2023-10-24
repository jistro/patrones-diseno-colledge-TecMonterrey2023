// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;


contract Almacenamiento {

    mapping(address => string ) private _nombres;

    function guardarNombre(address user, string memory nombre) public {
        _nombres[user] = nombre;
    }

    function obtenerNombre(address user) public view returns (string memory) {
        return _nombres[user];
    }

}

contract Interaccion {
    
        Almacenamiento private _almacenamiento;
    
        constructor(address almacenamiento) {
            _almacenamiento = Almacenamiento(almacenamiento);
        }
    
        function guardarNombre(string memory nombre) public {
            _almacenamiento.guardarNombre(msg.sender, nombre);
        }
    
        function obtenerNombre(address user) public view returns (string memory) {
            return _almacenamiento.obtenerNombre(user);
        }
}