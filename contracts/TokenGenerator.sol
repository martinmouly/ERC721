pragma solidity ^0.6.0;
import "./MyNFT.sol";

contract TokenGenerator {
    
    constructor(MyNFT _myNFT) public{
        uint tokenId = _myNFT.declareAnimal(0,3,true,"-VuS0pKOImWr7Bj");
        uint tokenId2 = _myNFT.declareAnimal(1,2,true,"animal trop stylé");
    }
}