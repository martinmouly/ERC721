pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721
{
	struct Animal {
  		uint sex;
  		uint legs;
		bool wings;
		string name;	
	}
	
	Animal[] public animals;
	address[] public breeders;

	constructor() ERC721("Martinooo","MLY") public{
		breeders.push(0x7bC0F471b287da69f0fb1bCF2218Fab947BBe0e9);
	}
	

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external returns (uint256){
			animals.push(Animal(sex, legs, wings, name));
			uint animalId=animals.length-1;
			return animalId;
	}
	function mintAnimal(address receiver,uint tokenId) external returns (bool){
		_mint(receiver,tokenId);
		return true;
	}
	//uint animalNumber1 = declareAnimal(1,2,true,"cEzbdUBOXkbib3z");

	function getAnimalCharacteristics(uint animalNumber) external returns (string memory _name, bool _wings, uint _legs, uint _sex){
		return(animals[animalNumber].name, animals[animalNumber].wings, animals[animalNumber].legs, animals[animalNumber].sex);
	}

	

	
	
	function isBreeder(address account) external returns (bool){
		bool doesListContainElement = false;
		for (uint i=0; i < breeders.length; i++) {
    		if (account == breeders[i]) {
        		doesListContainElement = true;
    		}
		}
		return doesListContainElement;
	}

	function registrationPrice() external returns (uint256){
		return 1;
	}
	
	function registerMeAsBreeder() external payable{
		breeders.push(msg.sender);
	}
/*
	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external returns (uint256);

	function getAnimalCharacteristics(uint animalNumber) external returns (string memory _name, bool _wings, uint _legs, uint _sex);

	function declareDeadAnimal(uint animalNumber) external;

	function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);

	function isAnimalForSale(uint animalNumber) external view returns (bool);

	function animalPrice(uint animalNumber) external view returns (uint256);

	function buyAnimal(uint animalNumber) external payable;

	function offerForSale(uint animalNumber, uint price) external;*/
}
