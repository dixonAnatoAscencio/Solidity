pragma solidity >= 0.4.4 <0.7.0;


contract Ejemplo_enumeraciones {

    //Enumeracion de interruptor
    enum estado {ON,OFF}

    //Variable de tipo enum(estado)
    estado state;


    function encender() public {
        state = estado.ON;
    }

    function fijarEstado(uint _k) public {
        state = estado(_k);
    }

    function Estado() public view returns(estado) {
        return state;
    }

    //Enumeracion de direcciones 
    enum direcciones {ARRIBA, ABAJO, IZQUIERDA, DERECHA}

    //Variable de tipo enum(direcciones)
    direcciones direccion = direcciones.ARRIBA;

    function arriba() public {
        direccion = direcciones.ARRIBA;
    }

     function abajo() public {
        direccion = direcciones.ABAJO;
    }

     function izquierda() public {
        direccion = direcciones.IZQUIERDA;
    }

     function derecha() public {
        direccion = direcciones.DERECHA;
    }

    function fijarDirecciones(uint _k) public {
         direccion = direcciones(_k);
    }

    function Direcciones() public view returns(direcciones) {
        return direccion;
    }
}