pragma solidity ^0.6.0;
import "./MyNFT.sol";

contract Token1 {
    
    constructor(MyNFT _myNFT) public{
        uint tokenId = _myNFT.declareAnimal(1,2,true,"cEzbdUBOXkbib3z");
        _myNFT.mintAnimal(address(0xa0b9f62A0dC5cCc21cfB71BA70070C3E1C66510E),tokenId);
    }
}