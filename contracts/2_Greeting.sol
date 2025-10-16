// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Greeting Message Storage
 * @dev String storage and retrieval with concatenation
 * @author Workshop Demo
 */
contract Greeting {
    // State variable to store the greeting message
    string public greeting;
    
    // Event to log greeting changes
    event GreetingChanged(string oldGreeting, string newGreeting);
    
    // Constructor - sets initial greeting
    constructor() {
        greeting = "Welcome to the blockchain!";
    }
    
    /**
     * @dev Set a new greeting message
     * @param _greeting The new greeting message
     */
    function setGreeting(string memory _greeting) public {
        string memory oldGreeting = greeting;
        greeting = _greeting;
        emit GreetingChanged(oldGreeting, greeting);
    }
    
    /**
     * @dev Get the current greeting message
     * @return The current greeting
     */
    function getGreeting() public view returns (string memory) {
        return greeting;
    }
    
    /**
     * @dev Create a personalized greeting
     * @param name The name to include in the greeting
     * @return A personalized greeting string
     */
    function greet(string memory name) public view returns (string memory) {
        // Note: In production, you'd use a string concatenation library
        // For demo purposes, we'll return a simple concatenation
        return string(abi.encodePacked("Hello, ", name, "! ", greeting));
    }
    
    /**
     * @dev Get the length of the current greeting
     * @return The length of the greeting string
     */
    function getGreetingLength() public view returns (uint256) {
        return bytes(greeting).length;
    }
}
