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

def display_board(board)
  puts %{
(1)|(2)|(3)
#{markers_line(board, 0)}
   |   |
---+---+---
(4)|(5)|(6)
#{markers_line(board, 1)}
   |   |
---+---+---
(7)|(8)|(9)
#{markers_line(board, 2)}
   |   |
  }
end

def markers_line(board, nbr)
  " #{board[nbr][0]} | #{board[nbr][1]} | #{board[nbr][2]} "
end

def player_marks_square!(board)
  selection = get_selection(board)
  board.flatten[selection].gsub!(INITIAL_MARKER, PLAYER_MARKER)
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
  board.flatten[choice - 1] == INITIAL_MARKER
end

def computer_marks_square!(board)
  board.flatten
       .select { |el| el == INITIAL_MARKER }
       .sample
       &.gsub!(INITIAL_MARKER, COMPUTER_MARKER)
end

def board_full?(board)
  board.flatten.select { |el| el == INITIAL_MARKER }.empty?
end

def detect_winner(board)
  winning_lines =
    horizontal_lines(board) +
    vertical_lines(board) +
    diagonal_lines(board)

  return 'player' if player_won?(winning_lines)
  return 'computer' if computer_won?(winning_lines)

  false
end

def horizontal_lines(board)
  [board[0], board[1], board[2]]
end

def vertical_lines(board)
  [
    [board[0][0], board[1][0], board[2][0]],
    [board[0][1], board[1][1], board[2][1]],
    [board[0][2], board[1][2], board[2][2]]
  ]
end

def diagonal_lines(board)
  [
    (0..2).collect { |i| board[i][i] },
    (0..2).collect { |i| board[i][-(1 + i)] }
  ]
end

def player_won?(winning_lines)
  winning_lines.any? do |line|
    line.all? { |el| el == PLAYER_MARKER }
  end
end

def computer_won?(winning_lines)
  winning_lines.any? do |line|
    line.all? { |el| el == COMPUTER_MARKER }
  end
end

def prompt(string)
  puts "==> #{string}"
end

prompt "Welcome to Tic Tac Toe. Let's get started!"

loop do
  board = Array.new(3) { Array.new(3) { INITIAL_MARKER.dup } }
  display_board(board)

  loop do
    player_marks_square!(board)
    computer_marks_square!(board)
    display_board(board)
    if (winner = detect_winner(board))
      prompt "#{winner} won!"
      break
    elsif board_full?(board)
      prompt "It's a tie!"
      break
    end
  end

  prompt 'Play again?'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe. Goodbye!"
