var Electron = artifacts.require("../contracts/Main.sol");

module.exports = function(deployer) {
    deployer.deploy(Electron);
}