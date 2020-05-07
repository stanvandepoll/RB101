require 'pry'

VALID_CHOICES = %w[rock paper scissors]

def prompt(message)
  puts "=> #{message}"
end

def display_result(choice, computer_choice)
  if won?(choice, computer_choice)
    prompt('You won!')
  elsif won?(computer_choice, choice)
    prompt('Computer won!')
  else
    prompt("It's a tie!")
  end
end

def won?(player_choice, opponent_choice)
  [['rock', 'scissors'], ['scissors', 'paper'], ['paper', 'rock']]
    .include?([player_choice, opponent_choice])
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

prompt('Get ready for Rock Paper Scissors!!! <=')

loop do
  choice = ask_choice
  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_result(choice, computer_choice)

  prompt('Do you want to play again?')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing! Goodbye!')
