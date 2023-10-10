// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

/**
 *  @title Ejemplo de patrón "Revisión de Guardias"
 *  @author Kevin Raul Padilla Islas -- jistro.eth
 *  @notice El patrón "Revisión de Guardias" se usa para verificar condiciones y 
 *          comportamientos en contratos, asegurando su correcto funcionamiento.
 */

contract ControlGuardia {
    error ControlGuardia__DireccionInvalida();
    error ControlGuardia__RegistroEmpleadoInvalido();
    error ControlGuardia__EmpleadoYaRegistrado();
    error ControlGuardia__EmpleadoNoRegistrado();
    error ControlGuardia__NumeroSectorInvalido();

    struct empleado {
        string nombreCompleto;
        string identificacion;
        uint8 sectorTrabajo;
    }

    mapping(address direccionEmpleado => empleado metadatos) s_empleados;

    function registrarEmpleado(
        address direccionEmpleado,
        string memory nombreCompleto,
        string memory identificacion,
        uint8 sectorTrabajo
    ) public {
        if (direccionEmpleado == address(0)) {
            revert ControlGuardia__DireccionInvalida();
        }
        if (s_empleados[direccionEmpleado].sectorTrabajo != 0) {
            revert ControlGuardia__EmpleadoYaRegistrado();
        }
        if (sectorTrabajo < 1 || sectorTrabajo > 3) {
            revert ControlGuardia__NumeroSectorInvalido();
        }
        s_empleados[direccionEmpleado] = empleado(nombreCompleto, identificacion, sectorTrabajo);
    }

    function verEmpleado(address direccionEmpleado) public view returns (empleado memory) {
        if (direccionEmpleado == address(0)) {
            revert ControlGuardia__DireccionInvalida();
        }
        if (s_empleados[direccionEmpleado].sectorTrabajo == 0) {
            revert ControlGuardia__EmpleadoNoRegistrado();
        }
        return s_empleados[direccionEmpleado];
    }
}
