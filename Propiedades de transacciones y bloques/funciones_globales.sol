pragma solidity ^0.8.4;

/*
Funciones Globales

block.blockhash(blockNumber) -- Devuelve el hash de un bloque dado(funciona para los 256 bloques mas recientes incluyendo el bloque actual)

block.coinbase -- Devuelve la direccion del minero que esta procesando el bloque actual.

block.difficulty -- Devuelve la dificultad del bloque actual en numero entero.

block.gaslimit -- Devuelve el limite del gas del bloque actual.

block.number -- Devuelve el numero del bloque actual.

block.timestamp -- Devuelve el timestamp del bloque actual en segundos.

msg.data -- Datos enviads en la transaccion.

msg.gas -- Devuelve el gas que queda.

msg.sender -- Devuelve el remitente de la llamada actual devuelve el addres con el remitente de la llamada actual.

msg.sig -- Devuelve los cuatros primeros bytes de los datos enviados en la transaccion

msg.value -- Devuelve el numero de Wei enviando con la llamada 

now  -- Devuelve el timestamp del bloque actual.

tx.gasprice -- Devuelve el precio del gas de la transaccion.

tx.origin -- Devuelve el emisor original de la transaccion.

*/