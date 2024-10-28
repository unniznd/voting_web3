// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Voting {
    struct Voter{
        bool isVoted;
        uint256 votedAt;
    }

    struct Candidate{
        uint256 candidateId;
        bytes32 name;
        uint256 voteCount;
    }

    mapping (address => Voter) private voteBank;

    Candidate[] public candidates;

    address public votingChairperson;
    bool isVotingFinished;
    uint256 candidateCount;

    event VotingFinished(uint256 completedAt);

    
    constructor(bytes32[] memory candidatesName, address[] memory voters) {
        votingChairperson = msg.sender;
        isVotingFinished = false;
        candidateCount = 0;

        for(uint256 i = 0; i<candidatesName.length; i++){
            candidates.push(
                Candidate({
                    candidateId: candidateCount,
                    name: candidatesName[i],
                    voteCount: 0
                })
            );
            candidateCount++;
        }

        for(uint256 i = 0; i<voters.length; i++){
            voteBank[voters[i]] = Voter({
                isVoted: false,
                votedAt: 0
            });
        }

    }

    function castVote()  public {
        
    }

    function finishVoting() public {
        require(msg.sender == votingChairperson, "Only chairperson can finish voting");
        require(!isVotingFinished, "Voting Already Finished");
        
        isVotingFinished = true;

        emit VotingFinished(block.timestamp);
    }
}