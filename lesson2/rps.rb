require 'pry'

VALID_CHOICES = %w[rock paper scissors lizard spock]

def prompt(message)
  puts "=> #{message}"
end

def determine_winner(choice, computer_choice)
  if won?(choice, computer_choice)
    'player'
  elsif won?(computer_choice, choice)
    'computer'
  end
end

def display_result(winner)
  return prompt("It's a tie!") unless winner

  prompt("#{winner} won the round!")
end

def adjust_score(score, winner)
  return unless winner

  score[winner.to_sym] += 1
end

def display_score(score)
  prompt("Score is: #{score.inspect}")
end

def won?(player_choice, opponent_choice)
  winning_combinations = {
    rock: ['scissors', 'lizard'],
    paper: ['rock', 'spock'],
    scissors: ['paper', 'lizard'],
    lizard: ['paper', 'spock'],
    spock: ['scissors', 'rock']
  }
  winning_combinations[player_choice.to_sym]
    .include?(opponent_choice)
end

def ask_choice
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end
  choice
end

prompt('Get ready for Rock Paper Scissors Lizard Spock!!! <=')
score = { player: 0, computer: 0 }

loop do
  loop do
    choice = ask_choice
    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    winner = determine_winner(choice, computer_choice)
    display_result(winner)
    adjust_score(score, winner)
    display_score(score)

    break if score[:player] > 4 || score[:computer] > 4
  end
  game_winner = score[:player] > 4 ? 'You' : 'Computer'
  prompt("#{game_winner} won the game!")

  prompt('Do you want to play again?')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing! Goodbye!')
