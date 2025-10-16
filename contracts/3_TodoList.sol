// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Todo List
 * @dev Managing a list of tasks with structs and arrays
 * @author Workshop Demo
 */
contract TodoList {
    // Struct to represent a task
    struct Task {
        string content;     // Task description
        bool completed;     // Completion status
        uint256 timestamp;  // When task was created
    }
    
    // Mapping to store tasks for each user
    mapping(address => Task[]) public userTasks;
    
    // Mapping to track task count per user
    mapping(address => uint256) public userTaskCount;
    
    // Events
    event TaskAdded(address indexed user, uint256 taskId, string content);
    event TaskCompleted(address indexed user, uint256 taskId);
    
    /**
     * @dev Add a new task
     * @param _content The task description
     * @return The task ID
     */
    function addTask(string memory _content) public returns (uint256) {
        Task memory newTask = Task({
            content: _content,
            completed: false,
            timestamp: block.timestamp
        });
        
        userTasks[msg.sender].push(newTask);
        uint256 taskId = userTasks[msg.sender].length - 1;
        userTaskCount[msg.sender]++;
        
        emit TaskAdded(msg.sender, taskId, _content);
        return taskId;
    }
    
    /**
     * @dev Mark a task as completed
     * @param _taskId The ID of the task to complete
     */
    function completeTask(uint256 _taskId) public {
        require(_taskId < userTasks[msg.sender].length, "Task does not exist");
        require(!userTasks[msg.sender][_taskId].completed, "Task already completed");
        
        userTasks[msg.sender][_taskId].completed = true;
        emit TaskCompleted(msg.sender, _taskId);
    }
    
    /**
     * @dev Get a specific task
     * @param _taskId The ID of the task
     * @return content, completed status, and timestamp
     */
    function getTask(uint256 _taskId) public view returns (
        string memory content,
        bool completed,
        uint256 timestamp
    ) {
        require(_taskId < userTasks[msg.sender].length, "Task does not exist");
        
        Task memory task = userTasks[msg.sender][_taskId];
        return (task.content, task.completed, task.timestamp);
    }
    
    /**
     * @dev Get the total number of tasks for the caller
     * @return The number of tasks
     */
    function getMyTaskCount() public view returns (uint256) {
        return userTasks[msg.sender].length;
    }
    
    /**
     * @dev Get the number of completed tasks for the caller
     * @return The number of completed tasks
     */
    function getCompletedTaskCount() public view returns (uint256) {
        uint256 completed = 0;
        for (uint256 i = 0; i < userTasks[msg.sender].length; i++) {
            if (userTasks[msg.sender][i].completed) {
                completed++;
            }
        }
        return completed;
    }
    
    /**
     * @dev Get all task IDs for the caller
     * @return Array of task IDs
     */
    function getMyTaskIds() public view returns (uint256[] memory) {
        uint256[] memory taskIds = new uint256[](userTasks[msg.sender].length);
        for (uint256 i = 0; i < userTasks[msg.sender].length; i++) {
            taskIds[i] = i;
        }
        return taskIds;
    }
}
