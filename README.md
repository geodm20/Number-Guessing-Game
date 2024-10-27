# Number-Guessing-Game
Number Guessing Game - final project of Relational DB course from freeCodeCamp

Complete the tasks below

1. Create a number_guessing_game folder in the project folder for your program2
2. Create number_guess.sh in your number_guessing_game folder and give it executable permissions
3. Your script should have a shebang at the top of the file that uses #!/bin/bash
4. Turn the number_guessing_game folder into a git repository
5. Your git repository should have at least five commits
6. Your script should randomly generate a number that users have to guess
7. When you run your script, you should prompt the user for a username with Enter your username:, and take a username as input. Your database should allow usernames that are 22 characters
8. If that username has been used before, it should print Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses., with <username> being a users name from the database, <games_played> being the total number of games that user has played, and <best_game> being the fewest number of guesses it took that user to win the game
9. If the username has not been used before, you should print Welcome, <username>! It looks like this is your first time here.
10. The next line printed should be Guess the secret number between 1 and 1000: and input from the user should be read
11. Until they guess the secret number, it should print It's lower than that, guess again: if the previous input was higher than the secret number, and It's higher than that, guess again: if the previous input was lower than the secret number. Asking for input each time until they input the secret number.
12. If anything other than an integer is input as a guess, it should print That is not an integer, guess again:
13. When the secret number is guessed, your script should print You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job! and finish running
14. The message for the first commit should be Initial commit
15. The rest of the commit messages should start with fix:, feat:, refactor:, chore:, or test:
16. You should finish your project while on the main branch, your working tree should be clean, and you should not have any uncommitted changes
