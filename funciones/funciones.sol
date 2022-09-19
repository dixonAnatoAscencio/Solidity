pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;


contract funciones{

    //Añadir dentro de un array de direcciones, la direccion de la persona que llame a la funcion
    address[] public direcciones;

    function nuevaDireccion() public{
        direcciones.push(msg.sender);
    }

    //Computar el hash de los datos proporcionados como parametro
    bytes32 public hash;

    function hash1(string memory _datos) public{
        hash = keccak256(abi.encodePacked(_datos));
    }

    //Declaramos un tipo de dato complejo, que es comida 
    struct comida{
        string nombre;
        string ingredientes;
    }

    //Vamos a crear un tipo de dato complejo
    comida public hamburguesa;
    function Hamburguesa(string  memory _ingredientes) public {
        hamburguesa = comida("hamburguesa", _ingredientes);
    }


    struct alumno{
        string nombre;
        address direccion;
        uint edad;
    }

    //Calculamos el hash del alummo
    bytes32 public hash_Id_alumno;
    function hashIdAlumno(string memory _nombre, address _direccion, uint _edad) private{
       hash_Id_alumno = keccak256(abi.encodePacked(_nombre, _direccion, _edad));
    }

    //Guardamos con la funcion publica dentro de una lista los alumnos
    alumno[] public lista;
    mapping(string => bytes32) alumnos;

    function nuevoAlumno(string memory _nombre, uint _edad) public {
        lista.push(alumno(_nombre, msg.sender, _edad));
        hashIdAlumno(_nombre, msg.sender, _edad);
        alumnos[_nombre] = hash_Id_alumno;
    }
}