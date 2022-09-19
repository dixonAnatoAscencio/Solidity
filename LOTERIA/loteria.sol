// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";


contract loteria {

    // Instancia del contrato token
    ERC20Basic private token;

    // Direcciones 
    address public owner;
    address public contrato;

    //Numero de tokens a crear
    uint tokens_creados = 10000;

    //Evento de compra de tokens 
    event ComprandoTokens (uint, address);


    constructor () public {

        token = new ERC20Basic(tokens_creados);
        owner = msg.sender;
        contrato = address(this);

    }


    //---------------------------------- TOKEN --------------------------//

    function PrecioTokens(uint _numTokens) internal pure returns (uint){
        return _numTokens*(1 ether);
    }


    //Funcion que permita generar mas tokens por la loteria 
    function GeneraTokens(uint _numTokens) public Unicamente(msg.sender){
        token.increaseTotalSupply(_numTokens);

    }

    //Modificador para hacer funciones solamente accesibles por el owner del contrato
    modifier Unicamente(address _direccion) {
        require (_direccion == owner,"No tienes permisos para ejecutar esta funcion");
        _;
    }


    //Comprar Tokens para comprar ticketes para la loteria
    function CompraTokens(uint _numTokens) public payable {
        //Calcular el coste de los tokens 
        uint coste = PrecioTokens(_numTokens);
        // Se requiere que el valor de ether pagado sea equivalente al coste
        require(msg.value >= coste, "Compra menos tokens o paga con mas ethers");
        //Diferencia a pagar 
        uint returnValue = msg.value - coste;
        //Transferencia de la diferencia o restante 
        msg.sender.transfer(returnValue);
        //Obtener el balance de Tokens del contrato
        uint Balance = TokensDisponibles();
        //Filtro para evaluar los tokens a comprar con los tokens disponibles
        require(_numTokens <= Balance, "Compra un numero de tokens adecuados.");
        //Tranferencia de tokens al comprador
        token.transfer(msg.sender, _numTokens);
        // Emitir el evento de compra tokens
        emit ComprandoTokens(_numTokens, msg.sender);

    }

    //Balance de tokens en el contrato de loteria
    function TokensDisponibles() public view returns (uint) {
        return token.balanceOf(address(contrato));
    }


    // Obtener el balance de tokens acumulados en el bote
    function Bote() public view returns (uint) {
        return token.balanceOf(owner);
    }

    
    //Balance de tokens de una persona
    function MisTokens() public view returns (uint) {
        return token.balanceOf(msg.sender);
    }

   // ---------------------------- LOTERIA ------------------------ 


   // Precio del ticket 
   uint public PrecioBoleto = 5;

   //Relacion entre la persona y los numeros de los boletos 
   mapping (address => uint [] ) idPersona_boletos;
   //Relacion necesaria para identificar al ganador
   mapping (uint => address) ADN_boleto;
   // Numero aleatorio 
   uint randNoce = 0;
   // Boletos generados
   uint [] boletos_comprados;

   //Eventos 
   event boleto_comprado(uint, address); //evento cuando se compra un boleto
   event boleto_ganador(uint); //evento del ganador 
   event tokens_devueltos(uint, address); //evento para devolver tokens





    // Funcion para comprar boletos de loteria 
    function CompraBoleto(uint _boletos) public {
        // Precio total de los boletos a comprar 
        uint precio_total = _boletos*PrecioBoleto;
        // Filtrado de los tokens a pagar 
        require (precio_total <= MisTokens(), "Necesitas comprar mas tokens");
        //Transferencia de tokens al owner -> bote/premio

        /*Ha sido necesario crear una funcion en ERC20 con el nombre transferencia_loteria debido a que en 
        caso de usar el transfer o transferFrom las direcciones que se escogia para realizar la transaccion eran equivocadas
        Ya que el msg.sender que recibia el metodo transfer o transferFrom era la direccion del contrato
        Y debe ser la direccion de la persona fisica.
        */
        token.transferencia_loteria(msg.sender, owner, precio_total);


        /*Lo que esto hace es tomar la marca de tiempo actual con now, el msg.sender y un nonce
         (un numero que solo se utiliza una vez, para que no ejecutemos dos veces la misma funcion de hash con los mismos parametros de entrada)
         en incremento, Luego se utiliza keccak256 para convertir estas entradas a un hash aleatorio, convertimos ese hash a un uint
         y luego utilizamos el % 10000 para tomar los ultimos cuatro digitos
         Dado un valor aleatorio entre 0 - 9999.
        */
        for(uint i = 0; i < _boletos; i++) {
            uint random = uint(keccak256(abi.encodePacked(now, msg.sender, randNoce))) % 10000;
            randNoce++;
            //Almacenamos los datos de los boletos 
            idPersona_boletos[msg.sender].push(random);
            //Numero de boleto comprado
            boletos_comprados.push(random);
            //asignacion del adn del boleto para tener un ganador 
            ADN_boleto[random] = msg.sender;
            //Emision del evento de compra de boletos 
            emit boleto_comprado(random, msg.sender);
        }
    }


    //Visualizar el numero de boletos de una persona 
    function TusBoletos() public view returns (uint [] memory){
        return idPersona_boletos[msg.sender];
    }

    //Funcion para generar un ganador y ingresarle los tokens 
    function GenerarGanador() public Unicamente(msg.sender) {
        //Debe haber boletos comprados para generar un ganador 
        require(boletos_comprados.length > 0, "No hay Boletos comprados ");
        //Declaracion de la longitud del array
        uint longitud = boletos_comprados.length;
        // Aleatoriamente elijo un numero entre: 0 - longitud
        // 1- Eleccion de una posicion aleatoria del array 
        uint posicion_array = uint(uint(keccak256(abi.encodePacked(now))) % longitud);
        // 2 - Seleccion del numero aleatorio mediante la posicion del array aleatorio
        uint eleccion = boletos_comprados[posicion_array];
        //Emision del evento ganador
        emit boleto_ganador(eleccion);
        //Recuperar la direccion del ganador 
        address direccion_ganador = ADN_boleto[eleccion];
        // Enviarle los tokens del premio al ganador 
        token.transferencia_loteria(msg.sender, direccion_ganador, Bote());

    }

    //Funcions de devolucion de los tokens 
    function DevolverTokens(uint _numTokens) public payable {
        // El numero de tokens a devolver debe ser mayor a 0
        require(_numTokens > 0 , "Nesecitasa devolver un numero positivo de tokens");
        //El usuario/cliente debe tener los tokens que desea devolver
        require(_numTokens <= MisTokens(), "No tienes los tokens que deseas devolver");
        //DEVOLUCION: 
        //1. El cliente devuelva los tokens 
        //2. la loteria paga los tokens devueltos en ethers
        token.transferencia_loteria(msg.sender, address(this), _numTokens);
        msg.sender.transfer(PrecioTokens(_numTokens));
        //Emision del evento
        emit tokens_devueltos(_numTokens, msg.sender);
    }


}
