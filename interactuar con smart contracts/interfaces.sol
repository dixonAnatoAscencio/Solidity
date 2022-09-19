pragma solidity >=0.4.4 <0.7.0;

/*Para interactuar con otro contrato de la blockchain es necesario hacer 
uso de las interfaces*/

/*
contract <nombre_interfaz>{
    //Declaramos las funciones con las que queremos interactuar 
    function <nombre_funcion>
}

*/

//Para hacer uso de la interfaz se deben realizar los siguientes pasos

//1--Declarar un puntero que apunte al otro contrato
//<nombre_interfaz> <nombre_puntero> = <nombre_interfaz> <direccion_contrato>

/*
2--Usar el puntero para usar las funcionalidades del otro contrato definidas en la interfaz
 <nombre_puntero>.<funcion>(<parametros>);
*/