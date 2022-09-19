// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.7.0;
pragma experimental ABIEncoderV2;

//-------------------------------------------
// ALUMNO |   ID  |  NOTA
//-------------------------------------------
// Juan | 77755N |   5
// -------------------------------------------
// luis | 12345X |     9
// -------------------------------------------
// MARIA | 02468T |    2
//-------------------------------------------
// MARTA | 13579U |    3
//-------------------------------------------
// Fernanda |  98765Z |    5
// -------------------------------------------
// DIXON | 45655N |   7
// -------------------------------------------

//funciones naranjas son restringidas y filtradas por el profesor
//azul son publicas 

contract notas{

    //Direccion del profesor
    address public profesor;

    //Constructor
    constructor () public {
        profesor = msg.sender;
    }

    //Mapping para relacionar el hash de la identidad del alumno con su nota del examen
    mapping (bytes32 => uint) Notas;

    // Array de los alumnos que pidan revision de los examenes
    string [] revisiones;


    //Eventos 
    event alumno_evaluado(bytes32);
    event evento_revision(string);


    //Funcion para evaluar alumnos
    function Evaluar(string memory _idAlumno, uint _nota) public UnicamenteProfesor(msg.sender){
        //Hash de la identificacion del alumno
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        //Relacion entre el hash de la identificacion del alumno y su nota
        Notas[hash_idAlumno] = _nota;
        //Emision del evento
        emit alumno_evaluado(hash_idAlumno);
    }

    //Control de las funciones ejecutables por el profesor
    modifier UnicamenteProfesor(address _direccion){
        //Requiere que la direccion introducida por parametro sea igual al owner del contrato
        require(_direccion == profesor, "No tienes permisos para ejecutar esta funcion. ");
        _;
    }

    //Funcion para ver las notas de un contrato
    function VerNotas(string memory _idAlumno) public view returns(uint){
        //Hash de la identificacion del alumno
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        //Nota asociada al hash del alumno
      uint nota_alumno = Notas[hash_idAlumno];
      //Visualizar la nota 
      return nota_alumno;

    }

    //Funcion para pedir revision del examen
    function Revision(string memory _idAlumno) public{
        //Almacenamiento de la identidad del alumno en un array
        revisiones.push(_idAlumno);
        //Emision del evento
        emit evento_revision(_idAlumno);
    }

    //Funcion para ver los alumnos que han solicitado revision de examenes
    function VerRevisiones() public view UnicamenteProfesor(msg.sender) returns(string [] memory){
        //Devolever las identidades de los alumnos
        return revisiones;
    }
}