pragma solidity >= 0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

//Keccak256() y abi.encodePacked() para pasar los argumentos a tipo byte
//para poder usar la función abi.encodePacked()
//pragma experimental ABIEncoderV2;

contract hash{
    //Computo del hash de un string
    function calcularHash(string memory _cadena) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_cadena));
        }
    // computo del hash de un string, un entero y una direccion
    function calcularHash2(string memory _cadena, uint _k, address _direccion) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_cadena, _k,  _direccion));
        }

    //computo del hash de un string, un entero y una direccion mas otra cadena y entero
    //que no estan dentro de una variable
    function calcularHash3(string memory _cadena, uint _k, address _direccion) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_cadena, _k,  _direccion, "hola", uint(2)));
         
        }

}