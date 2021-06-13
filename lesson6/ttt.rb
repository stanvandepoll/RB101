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

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def display_board(brd)
  puts %{
(1)|(2)|(3)
 #{brd[1]} | #{brd[2]} | #{brd[3]}
   |   |
---+---+---
(4)|(5)|(6)
 #{brd[4]} | #{brd[5]} | #{brd[6]}
   |   |
---+---+---
(7)|(8)|(9)
 #{brd[7]} | #{brd[8]} | #{brd[9]}
   |   |
  }
end

def player_marks_square!(board)
  selection = get_selection(board)
  board[selection] = PLAYER_MARKER
end

def get_selection(board)
  prompt "Place a marker #{available_squares(board).join(', ')}"
  selection = ''
  loop do
    selection = gets.chomp.to_i
    break if square_available?(choice: selection, board: board)

    prompt 'Invalid choice, please choose again'
  end
  selection
end

def square_available?(choice:, board:)
  available_squares(board).include?(choice)
end

def available_squares(board)
  board.keys.select {|num| board[num] == INITIAL_MARKER}
end

def computer_marks_square!(board)
  board[available_squares(board).sample] = COMPUTER_MARKER
end

def board_full?(board)
  board.values.select { |el| el == INITIAL_MARKER }.empty?
end

def detect_winner(board)
  winning_lines =
    horizontal_lines(board) +
    vertical_lines(board) +
    diagonal_lines(board)

  return 'player' if player_won?(board, winning_lines)
  return 'computer' if computer_won?(board, winning_lines)

  false
end

def horizontal_lines(board)
  [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
end

def vertical_lines(board)
  [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
end

def diagonal_lines(board)
  [[1, 5, 9], [3, 5, 7]]
end

def player_won?(board, winning_lines)
  winning_lines.any? do |line|
    line.all? { |num| board[num] == PLAYER_MARKER }
  end
end

def computer_won?(board, winning_lines)
  winning_lines.any? do |line|
    line.all? { |num| board[num] == COMPUTER_MARKER }
  end
end

def prompt(string)
  puts "==> #{string}"
end

def initialize_board
  new_board = {}
  (1..9).each {|num| new_board[num] = INITIAL_MARKER}
  new_board
end

prompt "Welcome to Tic Tac Toe. Let's get started!"

loop do
  board = initialize_board

  loop do
    display_board(board)
    player_marks_square!(board)
    break if detect_winner(board) || board_full?(board)

    computer_marks_square!(board)
    break if detect_winner(board)
  end

  display_board(board)
  winner = detect_winner(board)
  if winner
    prompt "#{winner} won!"
  elsif board_full?(board)
    prompt "It's a tie!"
  end

  prompt 'Play again?'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe. Goodbye!"
