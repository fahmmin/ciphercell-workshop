// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Simple Token (ERC20-like)
 * @dev Creating and transferring custom tokens
 * @author Workshop Demo
 */
contract SimpleToken {
    // Token information
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    // Owner of the contract
    address public owner;
    
    // Mapping to store balances
    mapping(address => uint256) public balances;
    
    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    
    // Modifier to restrict access to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // Constructor
    constructor() {
        name = "Workshop Token";
        symbol = "WST";
        decimals = 18;
        totalSupply = 0;
        owner = msg.sender;
    }
    
    /**
     * @dev Get the balance of an account
     * @param _account The account to check
     * @return The balance of the account
     */
    function balanceOf(address _account) public view returns (uint256) {
        return balances[_account];
    }
    
    /**
     * @dev Transfer tokens to another address
     * @param _to The address to transfer to
     * @param _amount The amount to transfer
     * @return Success status
     */
    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(_to != address(0), "Cannot transfer to zero address");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }
    
    /**
     * @dev Mint new tokens (owner only)
     * @param _to The address to mint tokens to
     * @param _amount The amount to mint
     */
    function mint(address _to, uint256 _amount) public onlyOwner {
        require(_to != address(0), "Cannot mint to zero address");
        require(_amount > 0, "Amount must be greater than 0");
        
        balances[_to] += _amount;
        totalSupply += _amount;
        
        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    }
    
    /**
     * @dev Get total supply of tokens
     * @return The total supply
     */
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }
    
    /**
     * @dev Get token information
     * @return _name Token name
     * @return _symbol Token symbol
     * @return _decimals Token decimals
     * @return _totalSupply Total supply
     */
    function getTokenInfo() public view returns (
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalSupply
    ) {
        return (name, symbol, decimals, totalSupply);
    }
    
    /**
     * @dev Check if an address has sufficient balance
     * @param _account The account to check
     * @param _amount The amount to check
     * @return Whether the account has sufficient balance
     */
    function hasSufficientBalance(address _account, uint256 _amount) public view returns (bool) {
        return balances[_account] >= _amount;
    }
}
