pragma solidity >=0.4.4 < 0.7.0;


//Array es un tipo de dato estructurado que almacena un conjunto homogeneo de datos 

//En solidity contamos con dos tipos de arrays

//Array de longitud fija es un array que esta definido su longitud

//Array dinámico no se determina su longitud 

//funcion .push() añade un elemento al final del array (solo se puede usar para arrays dinamicos)

//la funcion .length devuelve la longitud del array


contract Arrays{


    //Array de enteros de longitud fija 5 
    uint[5] public array_enteros = [1,2,3];

    //Arrays de enteros de 32 bits de longitud fija con 7 posiciones
    uint32[7] array_enteros_32_bits;

    //Array de string de longitud fija 15
    string[15] array_strings;

   
    //Array dinamico de enteros
    uint[] public miArray_dinamico_enteros;

    struct Persona{
        string nombre;
        uint edad;

    }

    //Array dinamico de tipo Persona
    Persona [] public array_dinamico_personas;

    function modificar_array() public {
      //  array_dinamico_personas.push(_numero);
     // array_dinamico_personas.push(Persona(_nombre, _edad));
     array_enteros[2]=15;
    }

    //acceder posicion del array 
    uint public test = array_enteros[2];

}


