pragma solidity >=0.4.4 < 0.7.0;

contract sentencia_if {

    //Numero ganador

    function probarSuerte(uint _numero) public pure returns(bool){
        bool ganador;
        if( _numero == 100){
            ganador = true;
        }else{
            ganador = false;
        }
        return ganador;

        
        /*
        bool ganador = false;
        if(_numero==100){
            ganador=true;
        }
        return ganador;
        */
    }


    //Calculamos el valor absoluto de un numero
    
    function valorAbsoluto(int _k) public pure returns(uint){
        uint valor_absoluto_numero;
        if( _k < 0){
          valor_absoluto_numero = uint(-_k);  
        }else{
            valor_absoluto_numero = uint(_k);
        }
        return valor_absoluto_numero;
    }

    //Devolver true si el numero introducido es par y tiene tres cifras

    function parTresCifras(uint _numero) public pure returns(bool){
        bool flag;
        //Usamos el and logico
        if((_numero%2==0)&&(_numero >= 100)&&(_numero<999)){
            flag = true;
        }else{
           flag = false; 
        }
        return flag;
    }

    //Votacion
    //solo hay tres candidatos: Joan, Dixon, Maria

    function votar(string memory _candidato) public pure returns(string memory){
        string memory mensaje;

    //Para comparar los strings debemos usar la funcion keccak256()
        if(keccak256(abi.encodePacked(_candidato)) == keccak256(abi.encodePacked("Dixon"))){
            mensaje = "Has votado correctamente por Dixon";
        }else{
            if(keccak256(abi.encodePacked(_candidato)) == keccak256(abi.encodePacked("Joan"))){
                mensaje = "Has votado correctamente por Joan";
            }else{
                if(keccak256(abi.encodePacked(_candidato)) == keccak256(abi.encodePacked("Maria"))){
                    mensaje = "Has votado correctamente por Maria";
                }else{
                    mensaje = "Has votado por un candidato que no esta en la lista";
                }
            }   
        }
        return mensaje;

    }

}
