// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.4;

import "@klaytn/contracts/access/AccessControlEnumerable.sol";

import "./libs/StatchStruct.sol";

contract StatchAdministrate is AccessControlEnumerable {
    bytes32 public constant VERSION_ROLE = "version";

    mapping (uint8 => StatchStruct.Info) versionToInfo;

    struct RoleAndAccount {
        bytes32 role;
        address account;
    }
    struct VersionAndInfo {
        uint8 version;
        StatchStruct.Info info;
    }

    event VersionGranted(uint8 indexed version, StatchStruct.Info indexed info, address indexed sender);

    modifier onlyValidInfo(StatchStruct.Info memory info) {
        require(info.digits < 78, "Digits should be less than uint256 length.");
        require(info.digits % info.eachLen == 0, "EachLen should be able to accurately divide the digits.");
        _;
    }

    constructor(RoleAndAccount[] memory roleArr, VersionAndInfo[] memory versionArr) {
        grantRole(VERSION_ROLE, _msgSender()); // give deployer to version role
        for (uint i=0; i<roleArr.length; i++) {
            grantRole(roleArr[i].role, roleArr[i].account);
        }
        for (uint i=0; i<versionArr.length; i++) {
            versionToInfo[versionArr[i].version] = versionArr[i].info;
        }
    }

    function getVersionInfo(uint8 version) public view virtual returns (StatchStruct.Info memory) {
        return versionToInfo[version];
    }

    function hasVersion(uint8 version) public view virtual returns (bool) {
        return versionToInfo[version].digits > 0;
    }

    function grantVersion(uint8 version, StatchStruct.Info memory info) public virtual onlyRole(VERSION_ROLE) {
        _grantVersion(version, info);
    }

    function _grantVersion(uint8 version, StatchStruct.Info memory info) internal virtual onlyValidInfo(info) {
        if (!hasVersion(version)) {
            versionToInfo[version] = info;
            emit VersionGranted(version, info, _msgSender());
        }
    }
}