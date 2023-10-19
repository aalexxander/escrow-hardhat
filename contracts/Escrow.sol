// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
    address public depositor;
    address public arbiter;
    address public beneficiary;
    bool public isApproved;

    event Approved(uint amount);

    modifier onlyArbiter() {
        require(msg.sender == arbiter, "msg.sender is not arbiter");
        _;
    }

    modifier notApproved() {
        require(!isApproved, "escrow is already approved");
        _;
    }

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external onlyArbiter notApproved {
        isApproved = true;
        uint amount = address(this).balance;
        payable(beneficiary).transfer(amount);
        emit Approved(amount);
    }
}
