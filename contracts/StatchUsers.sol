// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.4;

import "./StatchAdministrate.sol";
import "./libs/StatchUserStruct.sol";

contract StatchUsers is StatchAdministrate {
    using StatchUserStruct for StatchUserStruct.User;

    // id => User
    mapping (uint256 => StatchUserStruct.User) idToUser;
    mapping (address => uint256) addressToId;

    event Create(uint256 indexed id, address indexed addr, StatchUserStruct.User user);

    constructor(RoleAndAccount[] memory roleArr, VersionAndInfo[] memory versionArr) StatchAdministrate(roleArr, versionArr) {

    }

    function greet() external pure returns (string memory) {
        return "asdasd";
    }
}