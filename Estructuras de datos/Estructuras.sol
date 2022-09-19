pragma solidity >=0.4.4 < 0.7.0;

contract Estructuras{
     
    //Cliente de una pagina web
    struct cliente{
        uint id;
        string name;
        string dni;
        string mail;
        uint phone_number;
        uint credit_number;
        uint secret_number;
    }
    //declaramos variable de tipo cliente
    cliente cliente_1 = cliente(1, "Dixon", "1245567", "dixon@udemy.com", 3114567890, 1244, 21);

    //Amazon (cualquier pagina de cpmpra venta de productos)

    struct producto{
        string nombre;
        uint precio;

    }

    //Declaramos una variable de tipo producto 
    producto movil = producto("samsung", 500);

    //Proyecto coperativo de ONGs para ayudar a diversas causas
    struct ONG{
        address ong;
        string nombre;
    }

    //Declaramos una variable de tipo ONG
    ONG caritas = ONG(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 'caritas');

    struct Causa{
        uint id;
        string nombre;
        uint precio_objetivo;
    }

    //declaramos variable de tipo causa
    Causa medicamentos = Causa(1,"medicamentos", 1000);

}