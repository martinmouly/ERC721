pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721
{
	
	struct Animal {
  		uint sex;
  		uint legs;
		bool wings;
		string name;	
		bool isForSale;
		uint price;
		uint parent1;
		uint parent2;
		bool isRep;
		uint repPrice;
		address authorizedBreeder;
	}
	
	Animal[] public animals;
	address[] public breeders; 

	constructor() ERC721("Martinooo","MLY") public{
		breeders.push(0x7bC0F471b287da69f0fb1bCF2218Fab947BBe0e9); //adding my address to the list of breeders
		//breeders.push(0x4f82f7A130821F61931C7675A40fab723b70d1B8); //adding the evaluator to the list of breeders
	}
	

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external returns (uint256){
			animals.push(Animal(sex, legs, wings, name,false,0,1000 ether,1000 ether,false,0,address(0)));
			uint animalId=animals.length-1;
			_mint(msg.sender,animalId);
			return animalId;
	}

	function declareAnimalWithParents(uint sex, uint legs, bool wings, string calldata name, uint parent1, uint parent2) external returns (uint256){
			require(canReproduce(parent1));
			require(canReproduce(parent2));
			animals[parent2].authorizedBreeder=address(0);
			animals.push(Animal(sex, legs, wings, name,false,0,parent1,parent2,false,0,address(0)));
			uint animalId=animals.length-1;
			_mint(msg.sender,animalId);
			return animalId;
	}

	function getParents(uint animalNumber) external returns (uint parent1,uint parent2){
		return(animals[animalNumber].parent1,animals[animalNumber].parent2);
	}
	

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

	
	function declareDeadAnimal(uint animalNumber) external{
			require(ownerOf(animalNumber)==msg.sender);
			_burn(animalNumber);
			animals[animalNumber].name="";
			animals[animalNumber].wings=false;
			animals[animalNumber].legs=0;
			animals[animalNumber].sex=0;

	}

	function tokenOfOwnerByIndex(address owner, uint256 index) public override view returns (uint256){
		uint256 tokenId;
		for (uint i=0; i < animals.length; i++) {
    		if (owner == ownerOf(i)) {
        		tokenId=i;
    		}
		}
		return tokenId;
		uint256 toReturn;
		
	}

	function isAnimalForSale(uint animalNumber) external view returns (bool){
		return animals[animalNumber].isForSale;
	}

	function animalPrice(uint animalNumber) external view returns (uint256){
		return animals[animalNumber].price;
	}

	function buyAnimal(uint animalNumber) external payable{
		require(animals[animalNumber].isForSale==true);
		_transfer(ownerOf(animalNumber),msg.sender,animalNumber);
	}

	function offerForSale(uint animalNumber, uint price) external{
		animals[animalNumber].isForSale=true;
		animals[animalNumber].price=price;
	}

	function canReproduce(uint animalNumber) public view returns (bool){
		return animals[animalNumber].isRep;
	}

	function reproductionPrice(uint animalNumber) public view returns(uint) {
		return animals[animalNumber].repPrice;
	}

	function offerForReproduction(uint animalNumber,uint price) external returns (bool){
		bool test=false;
		require(ownerOf(animalNumber)==msg.sender);
		animals[animalNumber].isRep=true;
		animals[animalNumber].repPrice=price;
		test=true;
		return test;
	}

	function authorizedBreederToReproduce(uint animalNumber) public view returns(address){
		return animals[animalNumber].authorizedBreeder;
	}

	function payForReproduction(uint animalNumber) external payable {
		animals[animalNumber].authorizedBreeder=msg.sender;
	}
}
