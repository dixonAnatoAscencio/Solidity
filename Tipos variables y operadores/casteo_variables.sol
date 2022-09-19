pragma solidity >= 0.4.4 <0.7.0;

/*
Podemos transformar un (uint o int) con y numero de bits a un int o un 
int con x numero de bits 

*/
 contract casteo {

     //Ejemplo de casteos de variables
     uint entero_8_bits = 42;
     uint entero_64_bits = 60000;
     uint entero_256_bits = 10000000;
     int entero_16_bits = 156;
     int entero_120_bits = 900000;
     int entero = 5000000;

     //Casteo de las variables
     uint64 public casteo_1 = uint64(entero_8_bits);
     uint64 public casteo_2 = uint64(entero_256_bits);
     uint8  public casteo_3 = uint8(entero_16_bits);
     int public casteo_4 = int(entero_120_bits);
     int public casteo_5 = int(entero_256_bits);


     function convertir(uint8 _k) public view returns(uint64){
         return uint64(_k);
     }
 }

