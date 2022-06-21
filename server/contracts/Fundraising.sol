contract Fundraising {
    uint256 public targetAmount;
    address public owner;
    mappint(address => uint256) public donations;

    uint256 public raisedAmount = 0;
    uint256 public finishTime = block.timestamp + 2 weeks;

    constructor(uint256 _targetAmount) {
        targetAmount = _targetAmount;
        owner = msg.sender;
    }

    receive() external payable {
        require(block.timestamp < finishTime, "Campaign is over");
        donations[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    function withdrawDonations() external {
        require(msg.sender == owner, "funds will not only be released to the owner");
        require(raisedAmount >= targetAmount, "The project did not reach the goal");
        payable(owner).transfer(raisedAmount);
    }

    function refund() external {
        require(block.timestamp > finishTime, "The campaign is still going");    
        require(raisedAmount < targetAmount, "The project already reached the goal");
        require(dontions[msg.sender] > 0, "There's no fund to return");
        uint256 toRefund = donations[msg.sender];
        donations[msg.sender] = 0;
        payable(msg.sender).transfer(toRefund);
    }

}