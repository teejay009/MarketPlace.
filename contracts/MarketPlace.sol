// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Listing {
    address public owner;
    string public itemName;
    uint256 public price;

    constructor(address _owner, string memory _itemName, uint256 _price) {
        owner = _owner;
        itemName = _itemName;
        price = _price;
    }
}

contract Marketplace {
    struct User {
        address userAddress;
        address listingContract;
    }

    mapping(address => User) public users;
    address[] public registeredUsers;

    event UserRegistered(address indexed user, address listingContract);

    function register(string memory _itemName, uint256 _price) public {
        require(users[msg.sender].userAddress == address(0), "User already registered");

        
        Listing listing = new Listing(msg.sender, _itemName, _price);

        
        users[msg.sender] = User(msg.sender, address(listing));
        registeredUsers.push(msg.sender);

        emit UserRegistered(msg.sender, address(listing));
    }

    function getAllUsers() public view returns (address[] memory) {
        return registeredUsers;
    }

    function getListingContract(address _user) public view returns (address) {
        return users[_user].listingContract;
    }
}
