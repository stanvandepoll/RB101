INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

HORIZONTAL_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
VERTICAL_LINES = [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
DIAGONAL_LINES = [[1, 5, 9], [3, 5, 7]]
WINNING_LINES = HORIZONTAL_LINES + VERTICAL_LINES + DIAGONAL_LINES
LINE_LENGTH = 3
BOARD_SIZE = 9
MIDDLE_SQUARE = 5

def display_board(brd, win_counts)
  system 'clear'
  puts rules_and_score_header(win_counts)
  puts brd_string(brd)
  puts ''
end

def rules_and_score_header(win_counts)
  %(
  -------------------
      TIC TAC TOE
  -------------------
  You are #{PLAYER_MARKER}, computer is #{COMPUTER_MARKER}.
  Win #{WIN_LIMIT} rounds to win the whole game.
  Rounds won; you: #{win_counts[:player]}, computer: #{win_counts[:computer]}
  -------------------
  )
end

def brd_string(brd)
  %(
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
  )
end

def player_marks_square!(board)
  selection = input_selection(board)
  board[selection] = PLAYER_MARKER
end

def input_selection(board)
  prompt "Place a marker #{join_or(available_squares(board))}"
  selected_square = ''
  loop do
    selected_square = gets.chomp
    break if ('1'..(BOARD_SIZE.to_s)).to_a.include?(selected_square) &&
             square_available?(
               selected_square: selected_square.to_i, board: board
             )

    prompt 'Invalid choice, please choose again'
  end
  selected_square.to_i
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
  return if perform_line_completion_move!(board, COMPUTER_MARKER)
  return if perform_line_completion_move!(board, PLAYER_MARKER)

  if available_squares(board).include?(MIDDLE_SQUARE)
    board[MIDDLE_SQUARE] = COMPUTER_MARKER
  else
    board[available_squares(board).sample] = COMPUTER_MARKER
  end
end

def perform_line_completion_move!(board, marker)
  at_risk_square = square_at_risk(board, marker)
  if at_risk_square
    board[at_risk_square] = COMPUTER_MARKER
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
  if line_values.count(marking) == (LINE_LENGTH - 1) &&
     line_values.count(INITIAL_MARKER) == 1
    at_risk_line_index = line_values.index(INITIAL_MARKER)
    line[at_risk_line_index]
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
  (1..BOARD_SIZE).each { |num| new_board[num] = INITIAL_MARKER }
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
    win_limit = gets.chomp
    break if ('1'..'20').to_a.include?(win_limit)

    prompt 'Invalid choice, please choose again'
  end
  win_limit.to_i
end

def input_starter_setting
  prompt 'Who may start? p = player, c = computer, a = alternate, r = random'

  starter_choice = ''
  loop do
    starter_choice = gets.chomp.downcase.to_sym
    break if %i(p c a r).include?(starter_choice)

    prompt 'Invalid choice, please choose again'
  end

  starter_translation = { p: :player, c: :computer, a: :alternate, r: :random }
  starter_translation[starter_choice]
end

def perform_turn!(board, current_player, win_counts)
  display_board(board, win_counts)
  place_piece!(board, current_player)
end

def process_round_score!(board, win_counts)
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

def player_wants_to_continue?
  prompt 'Play again? yes/no'
  validated_answer = nil

  loop do
    answer = gets.chomp.downcase
    validated_answer =
      case answer
      when 'yes' then true
      when 'no' then false
      end

    break unless validated_answer.nil?

    prompt 'Invalid input. Please try again'
  end

  validated_answer
end

def display_current_score(win_counts)
  prompt "Score is player #{win_counts[:player]}, "\
         "computer #{win_counts[:computer]}"
end

def start_new_round_message
  prompt 'Starting new round...'
  sleep 2
end

def display_final_score(win_counts)
  prompt "Final score is player: #{win_counts[:player]}"\
         " vs computer: #{win_counts[:computer]}"
end

def play_game!(win_counts, starter)
  loop do
    board = initialize_board
    starter = pick_starter(starter)
    current_player = starter

    play_round!(board, current_player, win_counts)

    display_board(board, win_counts)
    process_round_score!(board, win_counts)
    break if win_limit_reached?(win_counts)

    display_current_score(win_counts)
    start_new_round_message
  end
end

def play_round!(board, current_player, win_counts)
  loop do
    perform_turn!(board, current_player, win_counts)
    break if detect_winner(board) || board_full?(board)

    current_player = alternate_player(current_player)
  end
end

### START OF GAME CALLS ###

prompt "Welcome to Tic Tac Toe. Let's get started!"
WIN_LIMIT = input_win_limit
STARTER_SETTING = input_starter_setting

loop do
  win_counts = { player: 0, computer: 0 }
  starter = nil

  play_game!(win_counts, starter)

  display_final_score(win_counts)
  break unless player_wants_to_continue?
end

prompt "Thanks for playing Tic Tac Toe. Goodbye!"
