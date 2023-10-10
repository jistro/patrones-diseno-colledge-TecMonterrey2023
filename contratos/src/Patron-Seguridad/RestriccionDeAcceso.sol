// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract RestriccionDeAcceso is AccessControl {
    error RestriccionDeAcceso__RolInvalido();
    error RestriccionDeAcceso__DireccionInvalida();
    error RestriccionDeAcceso__RolNoRegistrado();
    error RestriccionDeAcceso__EmpleadoYaRegistrado();
    error RestriccionDeAcceso__EmpleadoNoRegistrado();
    error RestriccionDeAcceso__EmpleadoInactivo();
    error RestriccionDeAcceso__EmpleadoActivo();

    bytes32 constant ROL_ADMIN = keccak256("ROL_ADMIN");
    bytes32 constant ROL_EMPLEADO = keccak256("ROL_EMPLEADO");

    struct empleado {
        string nombre;
        string apellido;
        uint8 rol;
        bool status;
        uint256 fechaActivo;
        uint256 fechaInactivo;
    }

    mapping(address direccionEmpleado => empleado metadatos) public empleados;

    constructor(address direccionAdmin, string memory nombreAdmin, string memory apellidoAdmin) {
        _grantRole(ROL_ADMIN, direccionAdmin);
        empleados[direccionAdmin] = empleado(nombreAdmin, apellidoAdmin, 1, true, block.timestamp, 0);
    }

    modifier soloAdmin() {
        if (!hasRole(ROL_ADMIN, msg.sender)) {
            revert RestriccionDeAcceso__RolInvalido();
        }
        _;
    }

    modifier soloEmpleado() {
        if (!hasRole(ROL_EMPLEADO, msg.sender)) {
            revert RestriccionDeAcceso__RolInvalido();
        }
        _;
    }

    modifier accesoAdminYEmpleado() {
        if (!hasRole(ROL_ADMIN, msg.sender) && !hasRole(ROL_EMPLEADO, msg.sender)) {
            revert RestriccionDeAcceso__RolInvalido();
        }
        _;
    }

    modifier verificarAddress(address direccion) {
        if (direccion == address(0)) {
            revert RestriccionDeAcceso__DireccionInvalida();
        }
        _;
    }
    function registrarEmpleado(
        address direccionEmpleado,
        string memory nombreEmpleado,
        string memory apellidoEmpleado,
        uint8 rolEmpleado
    ) public soloAdmin verificarAddress(direccionEmpleado) {
        
        if (empleados[direccionEmpleado].rol != 0) {
            revert RestriccionDeAcceso__EmpleadoYaRegistrado();
        }
        if (rolEmpleado != 1 && rolEmpleado != 2) {
            revert RestriccionDeAcceso__RolNoRegistrado();
        }
        empleados[direccionEmpleado] = empleado(nombreEmpleado, apellidoEmpleado, rolEmpleado, true, block.timestamp, 0);
        if (rolEmpleado == 1) {
            _grantRole(ROL_ADMIN, direccionEmpleado);
        } else {
            _grantRole(ROL_EMPLEADO, direccionEmpleado);
        }
    }

    function verDatosEmpleado(
        address direccionEmpleado
    ) public view soloAdmin returns (empleado memory) {
        if (empleados[direccionEmpleado].rol == 0) {
            revert RestriccionDeAcceso__EmpleadoNoRegistrado();
        }
        return empleados[direccionEmpleado];
    }

    function despedirEmpleado(
        address direccionEmpleado
    ) public soloAdmin verificarAddress(direccionEmpleado) {
        if (empleados[direccionEmpleado].rol == 0) {
            revert RestriccionDeAcceso__EmpleadoNoRegistrado();
        }
        if (!empleados[direccionEmpleado].status) {
            revert RestriccionDeAcceso__EmpleadoInactivo();
        }
        empleados[direccionEmpleado].status = false;
        empleados[direccionEmpleado].fechaInactivo = block.timestamp;
        if (empleados[direccionEmpleado].rol == 1) {
            _revokeRole(ROL_ADMIN, direccionEmpleado);
        } else {
            _revokeRole(ROL_EMPLEADO, direccionEmpleado);
        }
    }

    function recontratarEmpleado(
        address direccionEmpleado
    ) public soloAdmin verificarAddress(direccionEmpleado) {
        if (empleados[direccionEmpleado].rol == 0) {
            revert RestriccionDeAcceso__EmpleadoNoRegistrado();
        }
        if (empleados[direccionEmpleado].status) {
            revert RestriccionDeAcceso__EmpleadoActivo();
        }
        empleados[direccionEmpleado].status = true;
        empleados[direccionEmpleado].fechaActivo = block.timestamp;
        empleados[direccionEmpleado].fechaInactivo = 0;
        if (empleados[direccionEmpleado].rol == 1) {
            _grantRole(ROL_ADMIN, direccionEmpleado);
        } else {
            _grantRole(ROL_EMPLEADO, direccionEmpleado);
        }
    }
}
