// SPDX-License-Idenntifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;
pragma experimental ABIEncoderV2;


contract OMS_COVID {

    //Direccion de la OMS -> Owner / Dueño del contrato
    address public OMS;

    // Constructor del contrato
    constructor () public {
        OMS = msg.sender;
    }

    // Mapping para relacionar los centros de salud (direccion/address) con la validez del sistema de 
    //gestion
    mapping (address => bool) public Validacion_CentrosSalud;

    //Relacionar una direccion de un centro de salud con su contrato
    mapping (address => address) public CentroSalud_Contrato;

    // Ejemplo 1: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 -> true = Tiene permisos para crear su smart contract
    // Ejemplo 2: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 -> false = No tiene permisos para crear su smart contract

    // Array de direcciones que almacene lo contratos de los centros de salud validados
    address []  public direcciones_contratos_salud;

    //Array de las direcciones que soliciten el acceso
    address [] Solicitudes;

    //Eventos a emitir
    event SolicitudAcceso (address);
    event NuevoCentroValidado (address);
    event NuevoContrato(address, address);
    


    //Modificador que permita unicamente la ejecucion de funciones por la OMS
    modifier UnicamenteOMS(address _direccion) {
        require(_direccion == OMS, "No tienes permisos para realizar esta funcion");
        _;
    }

    // Funcion para solicitar acceso al sistema medico
    function SolicitarAcceso() public {
        //Almacenar la direccion en el array de solicitudes
        Solicitudes.push(msg.sender);
        //Emision del evento
        emit SolicitudAcceso(msg.sender);

    }


    // Funcion que visualiza las direcciones que han solicitado este acceso
    function VisualizarSolicitudes() public view  UnicamenteOMS(msg.sender) returns(address [] memory) {
        return Solicitudes;        
    }



    //Funcion para validar nuevos centros de salud que puedan autogestionarse -> UnicamenteOMS
    function CentrosSalud (address _centroSalud) public UnicamenteOMS(msg.sender){
        //Asignacion del estado de validez al centro de salud
        Validacion_CentrosSalud[_centroSalud] = true;
        //Emision del evento
        emit NuevoCentroValidado(_centroSalud);
    }



    //Funcion que permita crear un contrato inteligente de un centro de salud
    function FactoryCentroSalud() public {

        //Filtrado para que unicamente los centros de salud validados sean capaces de ejectuar esta funcion
        require (Validacion_CentrosSalud[msg.sender] == true, "No tienes permisos para ejecutar esta funcion");
        //Generar un Smart Contract -> Generar su direccion
        address contrato_CentroSalud = address (new CentroSalud(msg.sender));
        //Alamcenamos la direccion del contrato en el array
        direcciones_contratos_salud.push(contrato_CentroSalud);
        //Relacion entre el centro de salud y su contrato
        CentroSalud_Contrato[msg.sender] = contrato_CentroSalud;
        //Emision del evento
        emit NuevoContrato(contrato_CentroSalud, msg.sender);

    }
}


//////////////////////////////////////////////////////////////////////7

//Contrato autogestionable por el centro de salud
contract CentroSalud {

    //Direcciones Iniciales
    address public DireccionCentroSalud;
    address public DireccionContrato;
    

    constructor (address _direccion) public {
        DireccionCentroSalud = address(this);
        DireccionContrato = _direccion;
    }

    //Mapping que relaciona una ID con un resultado dea prueba de covid 
    //mapping (bytes32 => bool) ResultadoCOVID;

    // Mapping para relacionar el hash de la prueba con el codigo IPFS
    // mapping (bytes32 => string) ResultadoCOVID_IPFS;


    // Mapping para relacionar el hash de la persona con los resultados (diagnostico, CODIGO IPFS)
    mapping (bytes32 => Resultados) ResultadosCOVID; 

    //Estructura de los resultados 
    struct Resultados {
        bool diagnostico;
        string CodigoIPFS;
    }

    //Eventos
    event NuevoResultado (bool, string);


    //Filtar las funciones a ejecutar por el centro de salud 
    modifier UnicamenteCentroSalud(address _direccion) {
        require (_direccion == DireccionCentroSalud, "No tienes permisos para ejecutar esta funcion");
        _;
    }

    // Funcion para emitir un resultado de una prueba Covid
    // Formato de los campos de entrada: | 12345x | true or false | QmeNJJhvzbhsKeQJ9KDSG5id75sHjPiUHNQHniyP457mgD

    function ResultadosPruevaCovid(string memory _idPersona, bool _resultadoCOVID, string memory _codigoIPFS) public UnicamenteCentroSalud(msg.sender){

        // Hash de la identificacion de la persona
        bytes32 hash_idPersona = keccak256(abi.encodePacked(_idPersona));
        // Relacion entre el hash de la persona y el resultado de la prueba covid
        //ResultadoCOVID[hash_idPersona] = _resultadoCOVID;
        // Relacion con el codigo IPFS
        //ResultadoCOVID_IPFS[hash_idPersona] = _codigoIPFS;

        //Relacion del hash de la persona con la estructura de resultados
        ResultadosCOVID[hash_idPersona] = Resultados(_resultadoCOVID, _codigoIPFS);
        //Emision del evento
        emit NuevoResultado(_resultadoCOVID, _codigoIPFS);

    }


    //Funcion que permita visualizar los resultados
    function VisualizarResultados(string memory _idPersona) public view returns (string memory _resultadoPrueba, string memory _codigoIPFS) {

        //Hash de la identidad de la persona
        bytes32 hash_idPersona = keccak256(abi.encodePacked(_idPersona));
        //Retorno de un boolenao como un string 
        string memory resultadoPrueba;
            if (ResultadosCOVID[hash_idPersona].diagnostico == true){
                resultadoPrueba = "Positivo";
            }else{
                resultadoPrueba = "Negativo";
            }

            // Retorno de los parametros necesarios
            _resultadoPrueba = resultadoPrueba;
            _codigoIPFS = ResultadosCOVID[hash_idPersona].CodigoIPFS;
    }

}