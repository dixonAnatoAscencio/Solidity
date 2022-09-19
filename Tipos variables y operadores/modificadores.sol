pragma solidity >= 0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

//Si añadimos el modificador public al declarar una variable, se creará una funcion getter

//Private: las variables private solo son visibles desde dentro del contrato.
//Internal: las variables internal solo son accesibles internamente.

contract public_private_internal {

    //modificador public
    uint public mi_entero = 45;
    string public mi_string = "Dixon";
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    //Modificador en private
    uint private mi_entero_privado = 10;
    bool private flag= true;

    function test(uint _k) public{
        mi_entero_privado = _k;
    }

    //modificador internal
    bytes32 internal hash = keccak256(abi.encodePacked("hola"));
    address internal direccion = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

}