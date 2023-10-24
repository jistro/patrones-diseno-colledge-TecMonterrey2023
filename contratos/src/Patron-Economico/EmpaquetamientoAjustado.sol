// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract EmpaquetameintoAjustado {
    struct StructBarato {
        uint8 a;
        uint8 b;
        uint8 c;
        uint8 d;
        bytes1 e;
        bytes1 f;
        bytes1 g;
        bytes1 h;
    }

    StructBarato public structBarato;

    function setStructBarato(
        uint8 a,
        uint8 b,
        uint8 c,
        uint8 d,
        bytes1 e,
        bytes1 f,
        bytes1 g,
        bytes1 h
    ) public {
        structBarato = StructBarato(a, b, c, d, e, f, g, h);
    }

    function getStructBarato()
        public
        view
        returns (
            StructBarato memory
        )
    {
        return (
            structBarato
        );
    }

    function addStructBarato() public {
        structBarato = StructBarato(1,2,3,4,"a","b","c","d");
    }
}