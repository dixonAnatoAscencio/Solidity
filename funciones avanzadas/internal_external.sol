pragma solidity >= 0.4.4 < 0.7.0;


/*
Internal--->Parecido a private solo se pueden llamar desde el contrato actual
o contratos que deriven de el 

External---> solo pueden ser llamadas desde fuera del contrato
*/


contract Comida{

    struct plato{
        string nombre;
        string ingredientes;
        uint tiempo;
    }

    //Declarar un array dinamico de platos
    plato [] platos;

    //Relacionamos con un mapping el nombre del plato con sus ingredientes
    mapping(string => string) ingredientes;

    //Funcion que nos permite dar de alta un nuevo plato
    function NuevoPlato(string memory _nombre, string memory _ingredientes, uint _tiempo) internal {
        platos.push(plato(_nombre, _ingredientes, _tiempo));
        ingredientes[_nombre] = _ingredientes;
    }
    function Ingredientes(string memory _nombre) internal view returns(string memory ) {
        return ingredientes[_nombre];
    }

}

contract Sandwich is Comida{

    function sandwich(string memory _ingredientes, uint _tiempo) external{
        NuevoPlato("Sandwich", _ingredientes, _tiempo);
    }

    function VerIngredientes() external view returns(string memory){
        return Ingredientes("Sandwich");
    }

}