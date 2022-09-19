// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";

contract Disney{

    //Direccion del contrato : 0xb0b2408aC7696e1210622271569B670043186b6A

    //---------------------------- DECLARACIONES INICIALES ---------------//

        // Instancia del contracto token
        ERC20Basic private token;


        //Direccion de Disney (owner)
        address payable public owner;
        

        //Constructor
        constructor () public {
            token = new ERC20Basic(10000);
            owner = msg.sender;
        }

        //Estructura de datos para almacenar a nuestros clientes de disney
        struct cliente {
            uint tokens_comprados;
            string [] atracciones_disfrutadas;
        }

        //Mapping para el registro de clientes
        mapping (address => cliente) public Clientes;


 //---------------------------- GESTION DE TOKENS ---------------//

        //Funcion para establecer el precio de un Token
        function PrecioTokens(uint _numTokens)internal pure returns (uint) {
            //Conversion de Tokens a Ethers: 1 Token -> ether
            return _numTokens*(1 ether);
        }

        //Funcion para comprar tokens en disney
        function CompraTokens(uint _numTokens) public payable {
            //Establecer el precio de los tokens
            uint coste = PrecioTokens(_numTokens);
            //Evaluamos que el cliente paga por los Tokens
            require (msg.value >= coste, "Compra menos Tokens o paga con mas ethers");
            //Diferencia de lo que el cliente pago
            uint returnValue = msg.value - coste;
            // Disney retorna la cantidad de ethers al cliente
            msg.sender.transfer(returnValue);
            
            // Obtencion del numero de tokens disponibles
            uint Balance = balanceOf();
            require(_numTokens <= Balance, "Compra un numero menor de tokens");
            
            //Se transfiere el numero de tokens al cliente
            token.transfer(msg.sender, _numTokens);

            //Registro de tokens comprados 
            Clientes[msg.sender].tokens_comprados += _numTokens;
        }


        // Balance de tokens del contrato disney
        function balanceOf() public view returns (uint) {
            return token.balanceOf(address(this));
        }

        //Visualizar el numero de tokens restantes de un cliente
        function MisTokens() public view returns (uint){
            return token.balanceOf(msg.sender);
        }

        //Funcion para generar mas tokens
        function GeneraTokens(uint _numTokens) public Unicamente(msg.sender) {
            token.increaseTotalSupply(_numTokens);
        }

        //Modificador para controlar las funciones ejecutables por disney
        modifier Unicamente(address _direccion) {
            require(_direccion == owner, "No tienes permisos para ejecutar esta funcion");
            _;
        }

        //---------------------------- GESTION DE DISNEY ------------------//
        
        //Eventos
        event disfruta_atraccion(string, uint, address);
        event nueva_atraccion(string, uint);
        event baja_atraccion(string);
        event nueva_comida(string, uint, bool);
        event baja_comida(string);
        event disfruta_comida(string, uint, address);

        //Estructura de datos de la atraccion
        struct atraccion {
            string nombre_atraccion;
            uint precio_atraccion;
            bool estado_atraccion;
        }

         //Estructura de datos de la comida
        struct comida {
            string nombre_comida;
            uint precio_comida;
            bool estado_comida;
        }
        
        // Mapping para relacionar un nombre de una atraccion con una estructura de datos de la
        //atraccion
        mapping (string => atraccion) public MappingAtracciones;

        // Mapping para relacionar un nombre de una comida con una estructura de datos de la
        //comida
        mapping (string => comida) public MappingComida;

        //Array para almacenar el nombre de las atracciones 
        string [] Atracciones;

        //Array para almacenar comidas que han realizado
        string [] Comidas;

        // Mapping para relacionar una identidad (cliente) con su historial en disney
        mapping (address => string []) HistorialAtracciones;

        // Mapping para relacionar una identidad (cliente) con su historial de comidas  en disney
        mapping (address => string []) HistorialComidas;  

        //Crear nuevas atracciones para Disney (Solo es ejecutable por disney)
        function NuevaAtraccion(string memory _nombreAtraccion, uint _precio) public Unicamente(msg.sender) {
            //Creacion de una atraccion en disney
            MappingAtracciones[_nombreAtraccion] = atraccion(_nombreAtraccion, _precio, true);
            // Alamcenamiento en un array del nombre de la atraccion
            Atracciones.push(_nombreAtraccion);
            //Emision del evento para la nueva atraccion
            emit nueva_atraccion(_nombreAtraccion, _precio);

        }

        //Crear nuevos menus para la comida en Disney (SOLO es ejecutable por disney)
        function NuevaComida(string memory _nombreComida, uint _precio) public Unicamente (msg.sender) {

            //Creacion de una comida en Disney
            MappingComida[_nombreComida] = comida(_nombreComida, _precio, true);
            //Almacenar en un array las coidas que ha realizado una persona
            Comidas.push(_nombreComida);
            //Emision del evento para la nueva comida en disney
            emit nueva_comida(_nombreComida, _precio,  true);
        }

        //Dar de baja a las atracciones en Disney
        function BajaAtraccion(string memory _nombreAtraccion) public Unicamente(msg.sender) {
            // El estado de la atraccion pasa a false => no esta en uso
            MappingAtracciones[_nombreAtraccion].estado_atraccion = false;
            //Emision del evento para la baja de la atraccion
            emit baja_atraccion(_nombreAtraccion);
        }

        //Dar de baja a las atracciones en Disney
        function BajaComida(string memory _nombreComida) public Unicamente(msg.sender) {
            // El estado de la atraccion pasa a false => no se puede comer
            MappingComida[_nombreComida].estado_comida = false;
            //Emision del evento para la baja de la comida
            emit baja_comida(_nombreComida);
        }

    //Visualizar las atracciones de Disney
    function AtraccionesDisponibles() public view returns (string [] memory){
        return Atracciones;
    }

     //Visualizar las comidas de disney
    function ComidasDisponibles() public view returns (string [] memory){
        return Comidas;
    }

    //Funcion para subirse a una atraccion y pagar en tokes 
    function SubirseAtraccion(string memory _nombreAtraccion) public {
        //Precio de la atraccion en tokens
        uint tokens_atraccion = MappingAtracciones[_nombreAtraccion].precio_atraccion;
        //Verifica si el estado de la atraccion esta disponible para su uso
        require(MappingAtracciones[_nombreAtraccion].estado_atraccion == true,
            "La atraccion no esta disponible en estos momentos");
        //Verifica el numero de tokens que tiene el cliente para subirse a la atraccion
        require(tokens_atraccion <= MisTokens(),
             "Necesitas mas tokens para subirte a esta atraccion");

        /* El cliente paga la atraccion en Tokens:       
         Ha sido necesario crear una funcion en ERC20.sol con el nombre de: transferencia_disney
         debido a que en caso de usar el transfer o transferFrom las direccion que se escogian para
         realizar la transaccion eran equivocadas.
         Ya que el msg.sender que recibia el metodo transfer o transferFrom era la direccion del contrato
        */

        token.transferencia_disney(msg.sender, address(this),tokens_atraccion);
        // Almacenamiento en el historial de atracciones del cliente
        HistorialAtracciones[msg.sender].push(_nombreAtraccion);
        //Emision del evento para disfrutar de la atraccion
        emit disfruta_atraccion(_nombreAtraccion, tokens_atraccion, msg.sender);

    }

    //Funcion para Comprar comidas con tokens  
    function ComprarComida(string memory _nombreComida) public {
        //Precio de la comida en tokens
        uint tokens_comida = MappingComida[_nombreComida].precio_comida;
        //Verifica si el estado de la comida esta disponible para consumo
        require(MappingComida[_nombreComida].estado_comida == true,
            "La comida no esta disponible en estos momentos");
        //Verifica el numero de tokens que tiene el cliente para subirse comprar comida
        require(tokens_comida <= MisTokens(),
             "Necesitas mas tokens para comprar comida");

        /* El cliente paga la atraccion en Tokens:       
         Ha sido necesario crear una funcion en ERC20.sol con el nombre de: transferencia_disney
         debido a que en caso de usar el transfer o transferFrom las direccion que se escogian para
         realizar la transaccion eran equivocadas.
         Ya que el msg.sender que recibia el metodo transfer o transferFrom era la direccion del contrato
        */

        token.transferencia_disney(msg.sender, address(this),tokens_comida);
        // Almacenamiento en el historial de comidas del cliente
        HistorialComidas[msg.sender].push(_nombreComida);
        //Emision del evento para disfrutar de la atraccion
        emit disfruta_comida(_nombreComida, tokens_comida, msg.sender);

    }
         // Visualiza el historial completo de atracciones disfrutadas por un cliente
        function Historial() public view returns (string [] memory) {
            return HistorialAtracciones[msg.sender];
        }

        // Visualiza el historial completo de comidas disfrutadas por un cliente
        function HistorialComida() public view returns (string [] memory) {
            return HistorialComidas[msg.sender];
        }



    //Funcion para que un cliente de disney pueda devolver tokens
    function DevolverTokens (uint _numTokens) public payable {
        // El numero de tokens a devolver es positivo
        require (_numTokens > 0, "Nesecitas devolver una cantidad positiva de tokens");
        //El usuario debe tener el numero de tokens que desea devolver
        require(_numTokens <= MisTokens(), "No tienes los tokens que deseas devolver");
        //El cliente devuelve los tokens
         token.transferencia_disney(msg.sender, address(this),_numTokens);
         //Devolucion de los ethers al cliente
         msg.sender.transfer(PrecioTokens(_numTokens));


    }
  
}



