// SPDX-License-Identifier: MIT
pragma abicoder v2;

pragma solidity ^0.7.0;

contract HallOfFame {
    struct Score {
        string username;
        uint256 score;
    }

    mapping(string => uint256[]) private userScores;
    mapping(string => uint256) private bestScores;
    Score[] private topScores;

    function uploadScore(string memory username, uint256 score) public {
        userScores[username].push(score);
        if (score > bestScores[username]) {
            bestScores[username] = score;
        }
        updateTopScores(username, score);
    }

    function getBestScore(string memory username) public view returns (bool exists, uint256 bestScore) {
        if (bestScores[username] > 0) {
            return (true, bestScores[username]);
        } else {
            return (false, 0);
        }
    }

    function getTopScores() public view returns (Score[] memory) {
        uint256 length = topScores.length < 100 ? topScores.length : 100;
        Score[] memory top100 = new Score[](length);
        for (uint256 i = 0; i < length; i++) {
            top100[i] = topScores[i];
        }
        return top100;
    }

    function updateTopScores(string memory username, uint256 score) internal {
        topScores.push(Score(username, score));
        for (uint256 i = topScores.length - 1; i > 0; i--) {
            if (topScores[i].score > topScores[i - 1].score) {
                Score memory temp = topScores[i];
                topScores[i] = topScores[i - 1];
                topScores[i - 1] = temp;
            } else {
                break;
            }
        }
        if (topScores.length > 100) {
            topScores.pop();
        }
    }
}