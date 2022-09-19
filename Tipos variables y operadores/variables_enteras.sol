pragma solidity >= 0.4.4 < 0.7.0


contract enteros {
   
    //variables enteras sin signo
    uint mi_primer_entero;
    uint mi_primer_entero_inicializado = 5;
    uint cota = 5000;

    //variables enteras sin signo con un numero especifico de bits.
    //tomar en cuenta si el numero cabe en los bits acordados.
    uint8 entero_8_bits;
    uint64 entero_64_bits = 6000;
    uint entero_16_bits;
    uint256 entero_256_bits;

    // variables enteras con signo
    int mi_primer_entero_signo;
    int miNumero = -4;
    int miNumero2 = 60;

    //variables enteras con signo con un numero especifico de bits 
    int72 entero_con_signo_72_bits;
    int240 entero_con_240_bits = 90000;
    int256 entero_con_256_bits;
}