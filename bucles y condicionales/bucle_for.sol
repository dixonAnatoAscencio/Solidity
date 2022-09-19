pragma solidity >= 0.4.4 < 0.7.0;

/*
El bucle for ejecuta un bloque de codigo un numero finito de veces
    
    for(<inicia_contador>; <comprobar_contador; <aumentar_contador>){
        //codigo a ejecutar
    }

*/

//Suma de los 100 primeros numeros a partir del numero introducido

contract bucle_for{

function suma(uint _numero) public pure returns(uint){
    
    uint Suma = 0;

    for(uint i =_numero; i<(100+_numero); i++){
        Suma = Suma +i;

    }
        
        return Suma;
    }

    //Recorrer array para buscar un valor

    //Esto es un array dinamico de direcciones.
    address [] direcciones;

    //Añade una direccion al array.
    function asociar() public{
        direcciones.push(msg.sender);
    }

    //Comprobar si la dirrecion esta en el array de direcciones .
    function comprobarAsociacion() public view returns(bool, address){
        
        for(uint i=0; i< direcciones.length; i++){
            if(msg.sender==direcciones[i]){
                return (true, direcciones[i]);
            }
        }

    }

    //Doble for: Suma los 10 primeros factoriales
    //3! = 3*2*1
    //n! = n*(n-1)*(n-2)*..*2*1

    function sumaFactorial() public pure returns(uint){

        uint suma =0;
        for(uint i=1; i<10; i++){

            uint factorial = 1;

                for(uint j=2; j<=i; j++){
                    factorial = factorial*j;
                }

            suma = suma + factorial;
        }
        return suma;
    }

}





