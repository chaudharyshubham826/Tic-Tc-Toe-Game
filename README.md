# Tic-Tc-Toe-Game

Assignment 2
Emulating Tic-Tac-Toe
Done by:- Shubham (2018CS10641)
- Overview:-
	In this assignment we have emulated Tic-Tac-Toe which takes user input and prints who won the game or if it is a draw. It takes the position as input and puts a “X” if player 1 is giving input and “O” if player 2 is giving input. Data section contains all the data declared and text section contains 

	Before taking input, it also prints the position grid which tells which number(1-9) corresponds to which grid. Also, it prints the current status of the grid after printing the position grid on the console.

- Printing error messages:-
			Error message is printed on the console under two conditions:-
				1.)When the position entered by the player is not in range(i.e, if it is >9 or  
<1). Then error message is printed saying “Please enter a valid position”.
				2.)When the grid corresponding to the position entered by the player is already filled with either “X” or “O”.

-Welcome screen & result:-
			It welcomes the players with a welcome screen and also gives some instructions for playing the game. After each input the grid, it checks if any of the player has won or not. The game ends with declaring the result on screen(Win or Draw).
 			If any player wins before 9 turns, the winner is declared as soon as the winning condition is satisfied and the program ends. It does not wait for the 9 turns to complete in that case. And if even after 9 turns, no player satisfies the condition for winning, draw is declared and the program ends.


