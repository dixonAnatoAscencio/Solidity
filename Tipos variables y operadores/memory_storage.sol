pragma solidity >= 0.4.4 <0.7.0;

//En solidity hay dos sitios donde se pueden guardar variables 

//Storage - se refiere a las variables que estan guardadas peranentemente en la blockchain
//Memory - estas variables son temporales en la memoria 

//ejemplo - las variables de estado que estan declaradas fuera de las funciones 
//son por defecto de tipo storage.

// y las variables que se declaran adentro de las funciones son por defecto de tipo memory

//Modificador Payable permite enviar y recibir ether, solo esta permitida para los tipos de 
//datos address
