# 1. Display the initial empty 3x3 board.
# 2. Ask the user to mark a square.
# 3. Computer marks a square.
# 4. Display the updated board state.
# 5. If winner, display winner.
# 6. If board is full, display tie.
# 7. If neither winner nor board is full, go to #2
# 8. Play again?
# 9. If yes, go to #1
# 10. Good bye!
require 'pry'

board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]

def display_board(board)
  puts %{
   |   |
 #{board[0][0]} | #{board[0][1]} | #{board[0][2]}
   |   |
---+---+---
   |   |
 #{board[1][0]} | #{board[1][1]} | #{board[1][2]}
   |   |
---+---+---
   |   |
 #{board[2][0]} | #{board[2][1]} | #{board[2][2]}
   |   |
  }
end

def player_marks_square(board)
  selection = get_selection(board)
  board.flatten[selection].gsub!(' ', 'X')
end

def get_selection(board)
  prompt 'Place a marker (1-9)'
  selection = ''
  loop do
    selection = gets.chomp.to_i
    break if (1..9).cover?(selection) &&
             square_available?(choice: selection, board: board)
    prompt 'Invalid choice, please choose again'
  end
  selection - 1
end

def square_available?(choice:, board:)
  board.flatten[choice - 1] == ' '
end

def prompt(string)
  puts "==> #{string}"
end

display_board(board)
player_marks_square(board)
