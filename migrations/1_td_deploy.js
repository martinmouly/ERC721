const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

const MyNFT = artifacts.require("MyNFT.sol");
const Token1 = artifacts.require("Token1.sol");

module.exports = async function (deployer) {
  await deployer.deploy(MyNFT);
  //await deployer.deploy(Token1,MyNFT.address);
};

