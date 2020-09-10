# Ruby Mastermind Game!

> The Mastermind Game and Minimax Algorithm Written for the Odin Project!

<div align='center'>
  <img src='./screenshots/mastermind.png' alt='Mastermind Game' />
</div><br>

## Demo

[![Run on Repl.it](https://repl.it/badge/github/@andrewbaldwin44/.cpp)](https://repl.it/@andrewbaldwin44/Mastermind#main.rb)

## How to Play?

_Let's Play Mastermind!_

The computer is the mastermind! They have created a top secret code that you must crack. You are the code breaker. You must use wits and strategy to break the code! With each guess you make, hints are given as to how close your guess was! Your guess is made by placing four colored pegs on the board. The mastermind will then give you colored clues:

<span style='color: red; font-weight: bold'>A red clue:</span><br>
Each red clue means you have placed the correct color, and its in the correct position!

<span style='color: green; font-weight: bold'>A green clue:</span><br>
Each green clue means you have placed the correct color, but its not in the correct position! You have 10 turns to guess the code! If you guess the code before your time runs out, you win!

## Features

1. Playing Mastermind against the computer
2. A minimax algorithm to crack the users code
3. Difficulty selection

## Dependecies

- Ruby 2.6.5 (or higher)

## Run the Project

__Clone the repo to your local machine using the terminal__:
```
$ git clone git@github.com:andrewbaldwin44/Mastermind_Ruby_Game.git
```

1. Navigate into the project directory `cd Mastermind_Ruby_Game`
2. Run the demo `ruby main.rb`

## References
  * [Donald Kuth's 5 guess algorithm](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Five-guess_algorithm)
  * [Minimax Algorithm Pseudocode](https://en.wikipedia.org/wiki/Minimax#Pseudocode)
  * [Beating Mastermind, Adam Forsyth, RubyConf 2018](https://www.youtube.com/watch?v=Okm_t5T1PiA)

## Author

👤 **Andrew Baldwin**

- Github: [@andrewbaldwin44](https://github.com/andrewbaldwin44)
