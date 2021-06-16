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
  selection = get_selection(board)
  board[selection] = PLAYER_MARKER
end

def get_selection(board)
  prompt "Place a marker #{join_or(available_squares(board))}"
  selection = ''
  loop do
    selection = gets.chomp.to_i
    break if square_available?(choice: selection, board: board)

    prompt 'Invalid choice, please choose again'
  end
  selection
end

def join_or(array, delimiter=', ', end_word='or')
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(" #{end_word} ")
  else array[0..-2].join(delimiter) + "#{delimiter}#{end_word} #{array.last}"
  end
end

def square_available?(choice:, board:)
  available_squares(board).include?(choice)
end

def available_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def computer_marks_square!(board)
  offensive_square = check_offensive_moves(board)
  if offensive_square
    board[offensive_square] = COMPUTER_MARKER
    return
  end

  defensive_square = check_defensive_moves(board)
  if defensive_square
    board[defensive_square] = COMPUTER_MARKER
  elsif available_squares(board).include?(5)
    board[5] = COMPUTER_MARKER
  else
    board[available_squares(board).sample] = COMPUTER_MARKER
  end
end

def check_defensive_moves(board)
  defensive_square = nil

  WINNING_LINES.each do |line|
    line_values = board.values_at(*line)
    if line_values.count(PLAYER_MARKER) == 2 &&
       line_values.count(INITIAL_MARKER) == 1
      defensive_line_index = line_values.index(INITIAL_MARKER)
      defensive_square = line[defensive_line_index]
      break
    end
  end

  defensive_square
end

def check_offensive_moves(board)
  offensive_square = nil

  WINNING_LINES.each do |line|
    line_values = board.values_at(*line)
    if line_values.count(COMPUTER_MARKER) == 2 &&
       line_values.count(INITIAL_MARKER) == 1
      offensive_line_index = line_values.index(INITIAL_MARKER)
      offensive_square = line[offensive_line_index]
      break
    end
  end

  offensive_square
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
  WINNING_LINES.any? do |line|
    line.all? { |num| board[num] == PLAYER_MARKER }
  end
end

def computer_won?(board)
  WINNING_LINES.any? do |line|
    line.all? { |num| board[num] == COMPUTER_MARKER }
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

prompt "Welcome to Tic Tac Toe. Let's get started!"
prompt 'Till how many wins would you like to play? (max 20)'

win_limit = ''
loop do
  win_limit = gets.chomp.to_i
  break if (1..20).cover?(win_limit)

  prompt 'Invalid choice, please choose again'
end
WIN_LOOP_LIMIT = win_limit

prompt 'Who may start? p = player, c = computer, a = alternate, r = random'
starter_choice = ''
loop do
  starter_choice = gets.chomp.to_sym
  break if %i(p c a r).include?(starter_choice)

  prompt 'Invalid choice, please choose again'
end
starter_translation = { p: :player, c: :computer, a: :alternate, r: :random }
STARTER_SETTING = starter_translation[starter_choice]

loop do
  player_win_count = 0
  computer_win_count = 0
  starter = nil

  loop do
    board = initialize_board
    starter = pick_starter(starter)
    current_player = starter

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if detect_winner(board) || board_full?(board)
    end

    display_board(board)
    winner = detect_winner(board)
    if winner
      if winner == 'player'
        player_win_count += 1
      else
        computer_win_count += 1
      end

      prompt "#{winner} won!"
    elsif board_full?(board)
      prompt "It's a tie!"
    end

    break if player_win_count >= WIN_LOOP_LIMIT ||
             computer_win_count >= WIN_LOOP_LIMIT

    prompt "Score is player #{player_win_count}, computer #{computer_win_count}"
    prompt 'Starting new game...'
    sleep 2
  end

  prompt "Final score is player: #{player_win_count}"\
         " vs computer: #{computer_win_count}"
  prompt 'Play again?'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe. Goodbye!"
