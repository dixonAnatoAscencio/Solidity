pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
//View: No modifica los datos pero si accede a ellos

//Pure: No accede ni siquiera a los datos 

//Payable: Permite recibir ether

contract view_pure_payable{

    //Modificdor view
    string[] lista_alumnos;

    function nuevo_alumno(string memory _alumno) public {
        lista_alumnos.push(_alumno);
    }

    function ver_alumno(uint _posicion) public view returns(string memory){
        return lista_alumnos[_posicion];
    }

    uint x=10;
    function sumarAx(uint _a) public view returns(uint){
        return x+_a;
    }

    //Modificador de pure
    //esta depende de los parametros que se le pasen a la funcion
    function exponenciacion(uint _a, uint _b) public pure returns(uint){
        return _a**_b;
    }


    //Modificador de payable
    mapping(address => cartera) DineroCartera;
    
    struct cartera{
        string nombre_persona;
        address direccion_persona;
        uint dinero_persona;
    }

        function Pagar(string memory _nombrePersona, uint _cantidad) public payable {
            cartera memory mi_cartera;
            //inicializamos la variable mi_cartera
            mi_cartera = cartera(_nombrePersona, msg.sender, _cantidad);
            DineroCartera[msg.sender]= mi_cartera;
        }
    
    function verSaldo() public view returns(cartera){
        return DineroCartera[msg.sender];
    }
}