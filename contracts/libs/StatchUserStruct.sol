// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.4;

import "./StatchStruct.sol";

library StatchUserStruct {
    struct User {
        uint8 version;
        uint256 equipment;
    }

    modifier onlyValidInfo(StatchStruct.Info memory info) {
        require(info.digits < 78, "Digits should be less than uint256 length.");
        require(info.digits % info.eachLen == 0, "EachLen should be able to accurately divide the digits.");
        _;
    }

    function splitEquipment(User storage user, StatchStruct.Info memory info) onlyValidInfo(info) internal view returns (uint8[] memory) {

        uint256 equipment = user.equipment % (10 ** info.digits);

        uint8[] memory arr;
        
        uint len = info.digits / info.eachLen;
        for (uint i=0; i<len; i++) {
            arr[i] = 0; // spliting equiptment
        }

        return arr;
    }

}
