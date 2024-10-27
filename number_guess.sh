#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Prompt for username
echo -e "\nEnter your username:"
read USERNAME

# Validate username
if [[ -z "$USERNAME" || ${#USERNAME} -gt 22 ]]
then
    echo "Invalid username. It must be non-empty and at most 22 characters."
    exit # Finish the script if invalid
fi

# Variable to verify user existence
USER_EXIST=0

# Check if user exists in the database
GET_USER=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")

# If the player is not found:
if [[ -z $GET_USER ]]
  then # Greet them
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here.\n"
    # And add them to the DB
    INSERT_USERNAME=$($PSQL "INSERT INTO users(username) VALUES ('$USERNAME')")
  else
    # Get his/her games number and best game
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$GET_USER'")
    BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$GET_USER'")
    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.\n"
    USER_EXIST=1
fi

# Generate secret number
NUMBER_GUESS=$(( RANDOM % 1000 + 1 ))
echo "El numero e $NUMBER_GUESS"

# Prompt guess
echo -e "\nGuess the secret number between 1 and 1000:"
GUESS_COUNT=0

# Go on a loop until guessing the correct number
while true
do
  read USER_GUESS

  # Validate if input is a number
  if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
    then
      # Ask the user to repeat again
      echo -e "\nThat is not an integer, guess again:"
      continue
    else

      # If the guess is correct
      if [[ $USER_GUESS -eq $NUMBER_GUESS ]]
      then # exit the loop if the guess is correct
        break
      fi

      # If it is a number, give hints
      if [[ $USER_GUESS -gt $NUMBER_GUESS ]]
        then
          echo "It's lower than that, guess again:"
        else 
          echo "It's higher than that, guess again:"
      fi

  fi
    # Increase the guess count variable
    ((GUESS_COUNT++))
done

# Tell the user if he/she guessed, and update guess count once more:
((GUESS_COUNT++))
echo "You guessed it in $GUESS_COUNT tries. The secret number was $NUMBER_GUESS. Nice job!"

# Check if it's the first time to update games played and best game values
if [[ $USER_EXIST == 1 ]]
  then # Get the existing counts to update them accordingly
    # Update every new game
    GET_GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
    UPDATE_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = ($GET_GAMES_PLAYED + 1) WHERE username = '$USERNAME'")
    # Update ONLY if the best_game improves
    GET_BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")
    if [[ $GUESS_COUNT -lt $GET_BEST_GAME ]]
    then
      UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game = $GUESS_COUNT WHERE username = '$USERNAME'")
    fi
  else # Add one game played and the number of guess
    ADD_FIRST_GAME=$($PSQL "UPDATE users SET games_played = 1 WHERE username = '$USERNAME'")
    ADD_GUESS_NUMBER=$($PSQL "UPDATE users SET best_game = $GUESS_COUNT WHERE username = '$USERNAME'")
fi