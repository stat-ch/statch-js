const StatchUsers = artifacts.require("StatchUsers");

module.exports = function (deployer) {
  deployer.deploy(StatchUsers);
};
