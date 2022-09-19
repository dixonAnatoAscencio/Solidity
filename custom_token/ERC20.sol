// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.7.0;
import "./SafeMath.sol";


//Dixon Anato ---> 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//Otro Usuario ---> 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//Otro Usuario2 --> 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

//0xaFC15e53212154bf13bC8C385E0846625127DdE5 direccion de mi contrato



//Interface de nuestro token ERC20
interface IERC20 {
    //¿Que necesita mi token para funcionar?

    //Devuelve la cantidad de tokens en existencia
    function totalSupply() external view returns(uint256);

    //Devuelve la cantidad de tokens para una direccion indicada por parametro
    function balanceOf(address account) external view returns(uint256);

    //Devuelve el numero de tokens que el spender podra gastar en nombre del propietario(owner) 
    //Numero de tokens que se puede operar y gastar en nombre de otro
    //Permitimos que alguine pueda actuar de broker 
    function allowance(address owner, address spender) external view returns(uint256);

    //Devuelve un valor booleano resultado de la operacion indicada 
    function transfer(address recipient, uint256 amount) external returns (bool);

    //Devuelve un valor booleano con el resultado de la operacion de gasto
    //sedo parte de mis tokens para que alguien los gaste y/o actue con ellos
    function approve(address spender, uint256 amount) external returns (bool);

    //Devuelve un valor booleano con el resultado de la operacion de paso de una cantidad de
    //tokens usando el metodo allowance 
    //Somos un broker intermediario que gasta un emisor de un propietario y los envia a un receptor
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    
    //Evento que se debe emitir cuando una cantidad de tokens pase de un origen a un destino
    event Transfer(address indexed from, address indexed to, uint256 value);

    //Evento que se debe emitir cuando se establece una asignacion con el metodo allowance()
    event Approval(address indexed owner, address indexed spender, uint value);


}

//Implementacion de las funciones del token ERC20
contract ERC20Basic is IERC20{

    string public constant name = "ERC20DixonBlockchain";
    string public constant symbol = "ERCX";
    uint8  public constant decimals = 2;

     event Transfer(address indexed from, address indexed to, uint256 tokens);
     event Approval(address indexed owner, address indexed spender, uint tokens);


     using SafeMath for uint256;

    mapping (address => uint) balances;
    mapping (address => mapping(address => uint)) allowed;
    uint256 totalSupply_;

    constructor (uint256 initialSupply) public {
        totalSupply_ = initialSupply;
        balances[msg.sender] = totalSupply_;
    }



    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function increaseTotalSupply(uint newTokensAmount) public {
        totalSupply_ += newTokensAmount;
        balances[msg.sender] += newTokensAmount;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256){
        return balances[tokenOwner];
    }

    function allowance(address owner, address delegate) public override view returns(uint256){
        return allowed[owner][delegate];
    }

 
    function transfer(address recipient, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[recipient] = balances[recipient].add(numTokens);
        emit Transfer(msg.sender, recipient, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool){
        //No es una transferencia directa entre el propietario y el buyer comprador, si no que ocurre a traves de nosotros 
        //Nosotros somos el delegado de mover una cantidad de tokens que no nos pertenece hacia el comprador

        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);
        
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }

}