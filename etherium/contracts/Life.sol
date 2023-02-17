// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Life {
    struct Connection {
        address newConnection;
    }

    mapping(address => Connection[]) userConnections;

    // Function to add a new connection for a user
    function addConnection(address user, address newConnection) public {
    require(msg.sender == user, "Only the user can add connections");
    require(newConnection != user, "Cannot connect to yourself");
    require(!isConnected(user, newConnection), "Already connected to this user");
    Connection memory newCon = Connection(newConnection);
    userConnections[user].push(newCon);
    }

    function isConnected(address user, address potentialConnection) public view returns (bool) {
        for (uint i = 0; i < userConnections[user].length; i++) {
            if (userConnections[user][i].newConnection == potentialConnection) {
                return true;
            }
        }
        return false;
    }

    // Function to remove a connection for a user
    function removeConnection(address user, address oldConnection) public {
        require(msg.sender == user, "Only the user can remove connections");
        uint indexToRemove;
        for (uint i = 0; i < userConnections[user].length; i++) {
            if (userConnections[user][i].newConnection == oldConnection) {
                indexToRemove = i;
                break;
            }
        }
        delete userConnections[user][indexToRemove];
    }

    // Function to show connections of an address
    function showConnections(address user) public view returns(address[] memory) {
      address[] memory connections = new address[](userConnections[user].length);
      for (uint i = 0; i < userConnections[user].length; i++) {
        connections[i] = userConnections[user][i].newConnection;
      }
      return connections;
    }

    // Function to show who has connected to a user
    function showConnectionsToUser(address user, address called) public view returns(address[] memory) {
      address[] memory connections = new address[](userConnections[user].length);
      uint index = 0;
      for (uint i = 0; i < userConnections[user].length; i++) {
          if (userConnections[user][i].newConnection == called) {
              connections[index] = userConnections[user][i].newConnection;
              index++;
          }
      }
      return connections;
    }
}