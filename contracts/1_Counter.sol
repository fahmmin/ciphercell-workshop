// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Simple Counter
 * @dev Basic state management - store and modify a single number
 * @author Workshop Demo
 */
contract Counter {
    // State variable to store the count
    uint256 public count;
    
    // Event to log count changes
    event CountChanged(uint256 oldCount, uint256 newCount);
    
    // Constructor - sets initial count to 0
    constructor() {
        count = 0;
    }
    
    /**
     * @dev Increment the count by 1
     */
    function increment() public {
        uint256 oldCount = count;
        count += 1;
        emit CountChanged(oldCount, count);
    }
    
    /**
     * @dev Decrement the count by 1
     */
    function decrement() public {
        uint256 oldCount = count;
        count -= 1;
        emit CountChanged(oldCount, count);
    }
    
    /**
     * @dev Reset the count to 0
     */
    function reset() public {
        uint256 oldCount = count;
        count = 0;
        emit CountChanged(oldCount, count);
    }
    
    /**
     * @dev Get the current count
     * @return The current count value
     */
    function getCount() public view returns (uint256) {
        return count;
    }
}
