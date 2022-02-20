// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract UsersContract {
    uint256 id;

    struct Users {
        uint256 id;
        string userName;
        string password;
    }

    Users[] users;

    function findIndex(uint256 _id) internal view returns (uint256) {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].id == _id) {
                return i;
            }
        }

        revert("User not found");
    }

    function isUserExist(string memory _userName) internal view {
        for (uint256 i = 0; i < users.length; i++) {
            string memory user = users[i].userName;

            if (
                keccak256(abi.encodePacked(user)) ==
                keccak256(abi.encodePacked(_userName))
            ) {
                revert("User already exist");
            }
        }
    }

    function createUser(string memory _userName, string memory _password)
        public
    {
        isUserExist(_userName);
        users.push(Users(id, _userName, _password));
        id++;
    }

    function getUser(uint256 _id) public view returns (uint256, string memory) {
        uint256 i = findIndex(_id);
        return (users[i].id, users[i].userName);
    }

    function updateUser(
        uint256 _id,
        string memory _userName,
        string memory _passowrd
    ) public {
        uint256 i = findIndex(_id);

        users[i].userName = _userName;
        users[i].password = _passowrd;
    }

    function deleteUser(uint256 _id) public {
        uint256 i = findIndex(_id);
        delete users[i];
    }
}
