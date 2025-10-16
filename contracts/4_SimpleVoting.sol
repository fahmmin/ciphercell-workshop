// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Simple Voting/Poll
 * @dev Democratic decision making with Yes/No voting
 * @author Workshop Demo
 */
contract SimpleVoting {
    // State variables
    bool public votingOpen;
    uint256 public yesVotes;
    uint256 public noVotes;
    address public owner;
    
    // Mapping to track who has voted
    mapping(address => bool) public hasVoted;
    
    // Events
    event VoteCast(address indexed voter, bool choice);
    event VotingClosed();
    event VotingOpened();
    
    // Modifier to restrict access to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // Constructor
    constructor() {
        owner = msg.sender;
        votingOpen = true;
        yesVotes = 0;
        noVotes = 0;
    }
    
    /**
     * @dev Cast a vote (true for Yes, false for No)
     * @param _choice The vote choice (true = Yes, false = No)
     */
    function vote(bool _choice) public {
        require(votingOpen, "Voting is closed");
        require(!hasVoted[msg.sender], "You have already voted");
        
        hasVoted[msg.sender] = true;
        
        if (_choice) {
            yesVotes++;
        } else {
            noVotes++;
        }
        
        emit VoteCast(msg.sender, _choice);
    }
    
    /**
     * @dev Get the current voting results
     * @return yesVotes The number of Yes votes
     * @return noVotes The number of No votes
     * @return totalVotes The total number of votes cast
     */
    function getResults() public view returns (
        uint256 _yesVotes,
        uint256 _noVotes,
        uint256 totalVotes
    ) {
        return (yesVotes, noVotes, yesVotes + noVotes);
    }
    
    /**
     * @dev Check if an address has voted
     * @param _voter The address to check
     * @return Whether the address has voted
     */
    function hasVotedCheck(address _voter) public view returns (bool) {
        return hasVoted[_voter];
    }
    
    /**
     * @dev Close the voting (owner only)
     */
    function closeVoting() public onlyOwner {
        require(votingOpen, "Voting is already closed");
        votingOpen = false;
        emit VotingClosed();
    }
    
    /**
     * @dev Reopen the voting (owner only)
     */
    function openVoting() public onlyOwner {
        require(!votingOpen, "Voting is already open");
        votingOpen = true;
        emit VotingOpened();
    }
    
    /**
     * @dev Get the winning choice
     * @return 0 if tied, 1 if Yes wins, 2 if No wins
     */
    function getWinner() public view returns (uint256) {
        if (yesVotes == noVotes) {
            return 0; // Tied
        } else if (yesVotes > noVotes) {
            return 1; // Yes wins
        } else {
            return 2; // No wins
        }
    }
    
    /**
     * @dev Get voting status
     * @return Whether voting is currently open
     */
    function isVotingOpen() public view returns (bool) {
        return votingOpen;
    }
}
