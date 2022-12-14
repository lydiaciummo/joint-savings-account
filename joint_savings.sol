/*
Joint Savings Account
---------------------

This is a smart contract that manages a joint savings account between two Ethereum addresses.
This contract allows the two addresses assigned to it to deposit and withdraw funds.

*/

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {
    // The variables for the addresses that will be sharing the account
    address payable accountOne;
    address payable accountTwo;
    // Variables that will record information about past transactions
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    // The variable that will store the current balance of the savings account
    uint public contractBalance;

    // Withdraw function
    function withdraw(uint amount, address payable recipient) public {
        // Ensure that only the two account owners can have access to the account
        require(recipient == accountOne || recipient == accountTwo, "You don't own this accouont!");
        //Ensure that the account has sufficient funds to make the withdrawal
        require(contractBalance >= amount, "Insufficient funds!");

        // Mark the account making the current withdrawal as the last to withdraw
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the funds to the recipient
        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to amount currently being withdrawn
        lastWithdrawAmount = amount;

        // Update the contract balance to the new balance after the withdrawal
        contractBalance = address(this).balance;
    }

    // Deposit function
    function deposit() public payable {
        // Update the contract balance to the new balance after the
        contractBalance = address(this).balance;
    }

    // A function that specifies which Ethereum addresses will be the owners of the joint savings account
    function setAccounts(address payable account1, address payable account2) public {
        // Assign the account variables to the addresses specified in the function parameters
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function so the contract is able to accept ether without the use of the deposit function
    function() external payable {}
}
