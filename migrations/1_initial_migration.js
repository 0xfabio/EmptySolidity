const Migrations = artifacts.require("Migrations");
const MoneyPrinter = artifacts.require("MoneyPrinter");
// const GetPrices = artifacts.require("GetPrices");

module.exports = function (deployer) {
  deployer.deploy(MoneyPrinter);
  // deployer.deploy(GetPrices);
};