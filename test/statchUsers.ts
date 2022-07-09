const StatchUsers = artifacts.require("StatchUsers");

contract("StatchUsers", (accounts) => {
  it("should be initilized", async () => {
    const statchUsersInstance = await StatchUsers.deployed();
    const str = await statchUsersInstance.greet();

    assert.equal(str, "asdasd", "str should be 'asdasd'");
  });
});
