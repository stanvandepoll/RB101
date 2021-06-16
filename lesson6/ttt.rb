require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

HORIZONTAL_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
VERTICAL_LINES = [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
DIAGONAL_LINES = [[1, 5, 9], [3, 5, 7]]
WINNING_LINES = HORIZONTAL_LINES + VERTICAL_LINES + DIAGONAL_LINES

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
  selection = input_selection(board)
  board[selection] = PLAYER_MARKER
end

def input_selection(board)
  prompt "Place a marker #{join_or(available_squares(board))}"
  selected_square = ''
  loop do
    selected_square = gets.chomp.to_i
    break if square_available?(selected_square: selected_square, board: board)

    prompt 'Invalid choice, please choose again'
  end
  selected_square
end

def join_or(array, delimiter=', ', end_word='or')
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(" #{end_word} ")
  else array[0..-2].join(delimiter) + "#{delimiter}#{end_word} #{array.last}"
  end
end

def square_available?(selected_square:, board:)
  available_squares(board).include?(selected_square)
end

def available_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def computer_marks_square!(board)
  return if perform_offensive_move(board)
  return if perform_defensive_move(board)

  if available_squares(board).include?(5)
    board[5] = COMPUTER_MARKER
  else
    board[available_squares(board).sample] = COMPUTER_MARKER
  end
end

def perform_offensive_move(board)
  offensive_square = square_at_risk(board, COMPUTER_MARKER)
  if offensive_square
    board[offensive_square] = COMPUTER_MARKER
    true
  else
    false
  end
end

def square_at_risk(board, marking)
  square_number = nil

  WINNING_LINES.each do |line|
    square_number = at_risk_square_in(
      line: line, board: board, marking: marking
    )
    break if square_number
  end

  square_number
end

def at_risk_square_in(line:, board:, marking:)
  line_values = board.values_at(*line)
  if line_values.count(marking) == 2 &&
     line_values.count(INITIAL_MARKER) == 1
    at_risk_line_index = line_values.index(INITIAL_MARKER)
    line[at_risk_line_index]
  end
end

def perform_defensive_move(board)
  defensive_square = square_at_risk(board, PLAYER_MARKER)
  if defensive_square
    board[defensive_square] = COMPUTER_MARKER
    true
  else
    false
  end
end

def board_full?(board)
  board.values.select { |el| el == INITIAL_MARKER }.empty?
end

def detect_winner(board)
  return 'player' if player_won?(board)
  return 'computer' if computer_won?(board)

  false
end

def player_won?(board)
  winning_line_filled?(board, PLAYER_MARKER)
end

def computer_won?(board)
  winning_line_filled?(board, COMPUTER_MARKER)
end

def winning_line_filled?(board, marker)
  WINNING_LINES.any? do |line|
    line.all? { |num| board[num] == marker }
  end
end

def prompt(string)
  puts "==> #{string}"
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def pick_starter(previous_starter)
  case STARTER_SETTING
  when :player then :player
  when :computer then :computer
  when :alternate
    if previous_starter
      alternate_player(previous_starter)
    else
      %i(player computer).sample
    end
  when :random
    %i(player computer).sample
  end
end

def place_piece!(board, current_player)
  if current_player == :player
    player_marks_square!(board)
  else
    computer_marks_square!(board)
  end
end

def alternate_player(current_player)
  current_player == :player ? :computer : :player
end

def input_win_limit
  prompt 'Till how many wins would you like to play? (max 20)'

  win_limit = ''
  loop do
    win_limit = gets.chomp.to_i
    break if (1..20).cover?(win_limit)

    prompt 'Invalid choice, please choose again'
  end
  win_limit
end

def input_starter_setting
  prompt 'Who may start? p = player, c = computer, a = alternate, r = random'

  starter_choice = ''
  loop do
    starter_choice = gets.chomp.to_sym
    break if %i(p c a r).include?(starter_choice)

    prompt 'Invalid choice, please choose again'
  end

  starter_translation = { p: :player, c: :computer, a: :alternate, r: :random }
  starter_translation[starter_choice]
end

def perform_turn(board, current_player)
  display_board(board)
  place_piece!(board, current_player)
end

def process_round_score(board, win_counts)
  winner = detect_winner(board)
  if winner
    if winner == 'player'
      win_counts[:player] += 1
    else
      win_counts[:computer] += 1
    end

    prompt "#{winner} won!"
  elsif board_full?(board)
    prompt "It's a tie!"
  end
end

def win_limit_reached?(win_counts)
  win_counts[:player] >= WIN_LIMIT ||
    win_counts[:computer] >= WIN_LIMIT
end

### START OF GAME CALLS ###

prompt "Welcome to Tic Tac Toe. Let's get started!"
WIN_LIMIT = input_win_limit
STARTER_SETTING = input_starter_setting

loop do
  win_counts = { player: 0, computer: 0 }
  starter = nil

  loop do
    board = initialize_board
    starter = pick_starter(starter)
    current_player = starter

    loop do
      perform_turn(board, current_player)
      break if detect_winner(board) || board_full?(board)

      current_player = alternate_player(current_player)
    end

    display_board(board)
    process_round_score(board, win_counts)
    break if win_limit_reached?(win_counts)

    prompt "Score is player #{win_counts[:player]}, "\
           "computer #{win_counts[:computer]}"
    prompt 'Starting new game...'
    sleep 2
  end

  prompt "Final score is player: #{win_counts[:player]}"\
         " vs computer: #{win_counts[:computer]}"
  prompt 'Play again?'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe. Goodbye!"
