const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

const MyNFT = artifacts.require("MyNFT.sol");
const TokenGenerator = artifacts.require("TokenGenerator.sol");

module.exports = async function (deployer) {
  //await deployer.deploy(MyNFT);
  await deployer.deploy(TokenGenerator,MyNFT.address);
};

