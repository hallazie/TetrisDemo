# Getting Started

This is a simple Tetris Demo that applied with a fully on-chain leaderboard, showcasing the ability to develope Fully on-chain game with Godot Engine, with our custom module https://github.com/qingfengzxr/gdscript-web3 for GDScript.

In this demo, all the score you submit will stored in a OP contract, and holding a global leaderboard of the Tetris game.

## Login & Logout

You can create a account for the leaderboard by login with Username and your OP PrivateKey.

The PrivateKey will only stored at local for communicating with the contract. You can delete the stored PrivateKey anytime by logout.

## Play

You can play Tetris either you have login or not. Once the current game is finished, you will be able to submit your score to OP contract if you have login.

## Leaderboard

The leaderboard will show top 100 score on the chain, and your personal best score.

# Eth Tool

We use functions in ./Scripts/eth_tool.gd to communicate with block chain.

The contract address is `0x811c5976EACB0A81dB447885F76C81172a782484`

* `func get_top_scores` will call `getTopScores` function in the contract, and return top 100 scores and their usernames respectively.

* `func get_best_score` will call `getBestScore` function in the contract, and return the best score for current login user.

* `func upload_score2` will call `uploadScore` function in the contract (with signed_transaction function), and upload the current score of current user.



