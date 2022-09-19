pragma solidity >= 0.4.4 <0.7.0;
//Indicamos la version



contract funciones_globales{
    
    function MsgSender() public view returns(address) {
        return msg.sender;
    }
    
    //Funcion now deprecada para versiones mayores
    function Now() public view returns(uint) {
        return now;
    }

    //Funcion block.coinbase
    function BlockCoinbase() public view returns(address) {
        return block.coinbase;
    }

    //Funcion block.difficulty
    function BlockDifficulty() public view returns(uint) {
        return block.difficulty;
    }

    // funcion block.number
    function BlockNumber() public view returns(uint) {
        return block.number;
    }

    //funcion msg.sig
    function MsgSig() public view returns(bytes4) {
        return msg.sig;
    }

    //funcion tx.gasprice
    function txGasPrice() public view returns(uint) {
        return tx.gasprice;
    }
}