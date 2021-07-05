DISPLAY_SPACER = "-----------------------------------------\n\n"
SUITS = %w(H D S C)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)
MAX_GAME_SCORE = 21
DECK = SUITS.product(VALUES)

def prompt(msg)
  puts "=> #{msg}"
end

def total(cards)
  values = cards.map(&:last)

  raw_sum = values.sum do |value|
    raw_score(value)
  end

  total_corrected_for_aces(raw_sum, values)
end

def raw_score(card_value)
  case card_value
  when 'A' then 11
  when 'J', 'Q', 'K' then 10
  else card_value.to_i
  end
end

def total_corrected_for_aces(raw_sum, values)
  sum = raw_sum
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > MAX_GAME_SCORE
  end

  sum
end

def to_sentence(array)
  "#{array[0..-2].join(', ')} and #{array.last}"
end

def display_round(player_cards, dealer_cards, dealer_turn: false)
  dealer_values = displayable_dealer_values(dealer_cards, dealer_turn)

  system 'clear'
  display_card_values(player: :dealer, values: dealer_values)
  display_points(
    player: :dealer, points: total(dealer_cards), show_points: dealer_turn
  )

  player_values = player_cards.map(&:last)
  display_card_values(player: :player, values: player_values)
  display_points(player: :player, points: total(player_cards))
end

def displayable_dealer_values(dealer_cards, dealer_turn)
  if dealer_turn
    dealer_cards.map(&:last)
  else
    ['unknown card'].concat(dealer_cards
                    .map(&:last)
                    .slice(1..-1))
  end
end

def display_card_values(player:, values:)
  prompt "#{player.to_s.capitalize} has #{to_sentence(values)}."
end

def display_points(player:, points:, show_points: true)
  prompt "#{player.to_s.capitalize} points: #{points}." if show_points
  puts DISPLAY_SPACER
end

def busted?(hand)
  total(hand) > MAX_GAME_SCORE
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

def player_turn!(player_cards, dealer_cards, cards)
  display_round(player_cards, dealer_cards)
  return :done if busted?(player_cards)

  answer = request_hit_or_stay
  return :done if answer == :stay

  player_cards.append(cards.pop)
  :continue
end

def request_hit_or_stay
  answer = nil
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    answer = gets.chomp.downcase
    break if ['h', 's'].include?(answer)

    prompt "Sorry, must enter 'h' or 's'."
  end

  { h: :hit, s: :stay }[answer.to_sym]
end

def after_player_turns_message(player_cards)
  if busted?(player_cards)
    prompt "You went bust with a #{player_cards.last.last}"
  else
    prompt "You chose to stay!"
  end

  prompt "Dealer's turn..."
  sleep(2)
end

def dealer_turn!(player_cards, dealer_cards, cards)
  display_round(player_cards, dealer_cards, dealer_turn: true)
  return :done if dealer_should_stop(player_cards, dealer_cards)

  prompt 'Dealer hits...'
  sleep(3)
  dealer_cards.append(cards.pop)

  :continue
end

def dealer_should_stop(player_cards, dealer_cards)
  total(dealer_cards) >= (MAX_GAME_SCORE - 4) ||
    busted?(dealer_cards) ||
    busted?(player_cards)
end

def after_dealer_turns_message(dealer_cards)
  sleep(3)
  if busted?(dealer_cards)
    prompt "Dealer went bust with a #{dealer_cards.last.last}"
  else
    prompt "Dealer chose to stay!"
  end
end

def display_winner(player_cards, dealer_cards)
  winner = determine_winner(player_cards, dealer_cards)

  prompt result_string(winner)
end

def determine_winner(player_cards, dealer_cards)
  if busted?(player_cards)
    return :dealer
  elsif busted?(dealer_cards)
    return :player
  end

  player_points = total(player_cards)
  dealer_points = total(dealer_cards)

  if player_points > dealer_points
    :player
  elsif player_points < dealer_points
    :dealer
  end
end

def result_string(winner)
  if winner.nil?
    "It's a tie."
  else
    "#{winner.to_s.capitalize} wins!"
  end
end

def player_round!(player_cards, dealer_cards, cards)
  loop do
    break if player_turn!(player_cards, dealer_cards, cards) == :done
  end

  after_player_turns_message(player_cards)
end

def dealer_round!(player_cards, dealer_cards, cards)
  loop do
    break if dealer_turn!(player_cards, dealer_cards, cards) == :done
  end

  after_dealer_turns_message(dealer_cards)
end

### Start of game calls ###

system 'clear'
prompt "Welcome to #{MAX_GAME_SCORE}"
sleep(2)

loop do
  cards = DECK.shuffle
  player_cards = [cards.pop, cards.pop]
  dealer_cards = [cards.pop, cards.pop]

  player_round!(player_cards, dealer_cards, cards)
  dealer_round!(player_cards, dealer_cards, cards) unless busted?(player_cards)

  display_winner(player_cards, dealer_cards)
  break unless player_wants_to_continue?
end
