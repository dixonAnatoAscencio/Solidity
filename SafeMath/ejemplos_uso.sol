pragma solidity >= 0.4.4 <0.7.0;
import "./SafeMath.sol";

//La libreria SafeMath nos previene de errores de overflow
//tambien ejemplo en caso de que intentemos almacenar un nro negativo en tipo de dato o
//variable que sea positivo

contract calculosSeguros{

    //Debemos declarar para que tipos de datos usaremos la libreria
    using SafeMath for uint;

    //Funcion suma segura
    function suma(uint _a, uint _b) public pure returns(uint){
        return _a.add(_b);
    }

     function resta(uint _a, uint _b) public pure returns(uint){
        return _a.sub(_b);
    }

    function multiplicacion(uint _a, uint _b) public pure returns(uint){
        return _a.mul(_b);
    }

}