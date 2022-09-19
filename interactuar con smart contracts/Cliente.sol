pragma solidity >=0.4.4 <0.7.0;
//import "./Banco.sol";
import {Banco, Banco2} from "./Banco.sol";




contract Cliente is Banco{

    function AltaCliente(string memory _nombre) public {
        NuevoCliente(_nombre);
    }

    function IngresarDinero(string memory _nombre, uint _cantidad) public {
        clientes[_nombre].dinero = clientes[_nombre].dinero + _cantidad; 
    }

    function RetirarDinero(string memory _nombre, uint _cantidad) public returns(bool){
        bool flag = true;
    //validamos si el dinero que quieres retirar es mayor a 0
    //tenemos que hacer un casteo de variables por que intentamos almacenar en una variable,
    // cuando la cantidad es mayor a lo que tiene
    //en una variable entero positivo un entero negativo 
        if(int(clientes[_nombre].dinero) - int(_cantidad) >= 0){
            //actualizamos la cantidad de dinero
            clientes[_nombre].dinero = clientes[_nombre].dinero - _cantidad;
        }else{
            flag = false;
        }
        return flag;

    }

    function ConsultarDinero(string memory _nombre) public view returns(uint){
        return clientes[_nombre].dinero;
    }

}

