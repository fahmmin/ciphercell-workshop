# Remix Testing Guide for 5 Smart Contracts

This guide will help you test each contract in Remix Ethereum IDE.

## Setup Instructions

1. Go to [remix.ethereum.org](https://remix.ethereum.org)
2. Create a new file for each contract
3. Copy and paste the contract code
4. Compile using Solidity 0.8.24
5. Deploy to Remix VM (London)
6. Test each function

---

## Contract 1: Simple Counter

### File: `1_Counter.sol`

### Testing Steps:
1. **Deploy**: Click "Deploy" (no constructor parameters needed)
2. **Test Functions**:
   - `getCount()` → Should return 0
   - `increment()` → Click and confirm transaction
   - `getCount()` → Should return 1
   - `increment()` → Click again
   - `getCount()` → Should return 2
   - `decrement()` → Click and confirm
   - `getCount()` → Should return 1
   - `reset()` → Click and confirm
   - `getCount()` → Should return 0

### Expected Results:
- Count starts at 0
- Each increment increases by 1
- Each decrement decreases by 1
- Reset brings count back to 0
- Events are emitted for each change

---

## Contract 2: Greeting Message Storage

### File: `2_Greeting.sol`

### Testing Steps:
1. **Deploy**: Click "Deploy"
2. **Test Functions**:
   - `getGreeting()` → Should return "Welcome to the blockchain!"
   - `getGreetingLength()` → Should return 30
   - `setGreeting("Hello World")` → Enter "Hello World" and click
   - `getGreeting()` → Should return "Hello World"
   - `greet("Alice")` → Enter "Alice" and click
   - Should return "Hello, Alice! Hello World"

### Expected Results:
- Initial greeting is set in constructor
- Can change greeting with setGreeting
- greet() function concatenates name with greeting
- Events are emitted when greeting changes

---

## Contract 3: Todo List

### File: `3_TodoList.sol`

### Testing Steps:
1. **Deploy**: Click "Deploy"
2. **Test Functions**:
   - `getMyTaskCount()` → Should return 0
   - `addTask("Learn Solidity")` → Enter task and click
   - `getMyTaskCount()` → Should return 1
   - `getTask(0)` → Should return task details
   - `addTask("Build DApp")` → Add second task
   - `getMyTaskCount()` → Should return 2
   - `completeTask(0)` → Mark first task complete
   - `getTask(0)` → Should show completed = true
   - `getCompletedTaskCount()` → Should return 1

### Expected Results:
- Each user has their own task list
- Tasks have content, completion status, and timestamp
- Can add multiple tasks
- Can mark tasks as completed
- Events are emitted for task operations

---

## Contract 4: Simple Voting/Poll

### File: `4_SimpleVoting.sol`

### Testing Steps:
1. **Deploy**: Click "Deploy" (deployer becomes owner)
2. **Test Functions**:
   - `isVotingOpen()` → Should return true
   - `getResults()` → Should return (0, 0, 0)
   - `vote(true)` → Vote "Yes" and confirm
   - `getResults()` → Should return (1, 0, 1)
   - `hasVotedCheck(deployer_address)` → Should return true
   - Switch to different account and `vote(false)` → Vote "No"
   - `getResults()` → Should return (1, 1, 2)
   - `getWinner()` → Should return 0 (tied)
   - As owner: `closeVoting()` → Close voting
   - `isVotingOpen()` → Should return false

### Expected Results:
- Voting starts open
- Each address can vote only once
- Results are tracked separately for Yes/No
- Owner can close/reopen voting
- Winner function shows result

---

## Contract 5: Simple Token

### File: `5_SimpleToken.sol`

### Testing Steps:
1. **Deploy**: Click "Deploy" (deployer becomes owner)
2. **Test Functions**:
   - `getTokenInfo()` → Should return token details
   - `balanceOf(deployer_address)` → Should return 0
   - `getTotalSupply()` → Should return 0
   - As owner: `mint(deployer_address, 1000)` → Mint 1000 tokens
   - `balanceOf(deployer_address)` → Should return 1000
   - `getTotalSupply()` → Should return 1000
   - Switch to different account
   - `transfer(other_account, 100)` → Transfer 100 tokens
   - `balanceOf(deployer_address)` → Should return 900
   - `balanceOf(other_account)` → Should return 100
   - `hasSufficientBalance(deployer_address, 500)` → Should return true

### Expected Results:
- Token has name, symbol, and decimals
- Only owner can mint tokens
- Tokens can be transferred between addresses
- Balances are tracked correctly
- Total supply updates with minting
- Events are emitted for transfers

---

## Common Testing Tips

### For All Contracts:
1. **Always check the console** for events and logs
2. **Use different accounts** to test multi-user functionality
3. **Check gas costs** for each transaction
4. **Verify state changes** after each transaction
5. **Test edge cases** (like transferring 0 tokens)

### Troubleshooting:
- **"Transaction failed"**: Check if you have enough gas
- **"Only owner" errors**: Make sure you're using the correct account
- **"Insufficient balance"**: Check your token balance before transfers
- **"Task does not exist"**: Use valid task IDs (0, 1, 2, etc.)

### Advanced Testing:
- **Test with multiple accounts** to see how contracts handle different users
- **Check event logs** in the Remix console
- **Monitor gas usage** for each function call
- **Test error conditions** by trying invalid inputs

---

## Workshop Demo Flow

1. **Start with Counter** - Show basic state management
2. **Move to Greeting** - Demonstrate string handling
3. **Show Todo List** - Introduce structs and arrays
4. **Demo Voting** - Explain access control and mappings
5. **Finish with Token** - Show token economics

Each contract builds on previous concepts while introducing new ones!
