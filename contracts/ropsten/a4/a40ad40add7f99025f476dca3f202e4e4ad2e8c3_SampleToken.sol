pragma solidity ^0.4.22;


contract SampleToken {

    /* Public variables of the token */
    string public standard = "Token 0.1";
    string public name = "ZToken";
    string public symbol = "ZTK";
    uint8 public decimals = 0;
    uint256 public totalSupply;
    address public owner;

    /* This creates an array with all balances */
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor() {
        uint256 initialSupply = 100000;
        balanceOf[msg.sender] = initialSupply;
        owner = msg.sender;

        // Give the creator all initial tokens
        totalSupply = initialSupply;
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value);
        // Check if the sender has enough
        if (balanceOf[_to] + _value < balanceOf[_to]) revert(); // TODO not safe for overflow
        // Check for overflows
        balanceOf[msg.sender] -= _value;
        // Subtract from the sender
        balanceOf[_to] += _value;
        // Add the same to the recipient
        emit Transfer(msg.sender, _to, _value);
        // Notify anyone listening that this transfer took place
    }
}