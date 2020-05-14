# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

require 'pry'

deck = [
  ['H', 'A'], ['S', 'A'], ['D', 'A'], ['C', 'A'],
  ['H', '2'], ['S', '2'], ['D', '2'], ['C', '2'],
  ['H', '3'], ['S', '3'], ['D', '3'], ['C', '3'],
  ['H', '4'], ['S', '4'], ['D', '4'], ['C', '4'],
  ['H', '5'], ['S', '5'], ['D', '5'], ['C', '5'],
  ['H', '6'], ['S', '6'], ['D', '6'], ['C', '6'],
  ['H', '7'], ['S', '7'], ['D', '7'], ['C', '7'],
  ['H', '8'], ['S', '8'], ['D', '8'], ['C', '8'],
  ['H', '9'], ['S', '9'], ['D', '9'], ['C', '9'],
  ['H', '10'], ['S', '10'], ['D', '10'], ['C', '10'],
  ['H', 'J'], ['S', 'J'], ['D', 'J'], ['C', 'J'],
  ['H', 'Q'], ['S', 'Q'], ['D', 'Q'], ['C', 'Q'],
  ['H', 'K'], ['S', 'K'], ['D', 'K'], ['C', 'K']
]

def total(cards)
  values = cards.map(&:last)

  sum = 0
  values.each do |value|
    sum += if value == 'A'
             11
           elsif value.to_i == 0 # J, Q, K
             10
           else
             value.to_i
           end
  end

  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def to_sentence(array)
  "#{array[0..-2].join(', ')} and #{array.last}"
end

def display_round(player_cards, dealer_cards, dealer_turn = false)
  dealer_values = if dealer_turn
                    dealer_cards.map(&:last)
                  else
                    ['unknown card'].concat(dealer_cards
                                    .map(&:last)
                                    .slice(1..-1))
                  end
  puts "Dealer has #{to_sentence(dealer_values)}"
  puts "Dealer points: #{total(dealer_cards)}" if dealer_turn

  player_values = player_cards.map(&:last)
  puts "Player has #{to_sentence(player_values)}"
  puts "Player points: #{total(player_cards)}"
  puts ''
  puts ''
end

def call_winner(player_cards, dealer_cards)
  if busted?(player_cards)
    return "Dealer wins!"
  elsif busted?(dealer_cards)
    return "Player wins!"
  end

  player_points = total(player_cards)
  dealer_points = total(dealer_cards)

  if player_points > dealer_points
    "Player wins!"
  elsif player_points < dealer_points
    "Dealer wins!"
  else
    "It's a tie"
  end
end

def busted?(hand)
  total(hand) > 21
end

def play_again?
  puts "-------------"
  puts "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

puts "Welcome to 21"

loop do
  cards = deck.shuffle
  player_cards = [cards.pop, cards.pop]
  dealer_cards = [cards.pop, cards.pop]

  loop do
    display_round(player_cards, dealer_cards)
    break if busted?(player_cards)

    answer = nil
    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = gets.chomp.downcase
      break if ['h', 's'].include?(answer)

      puts "Sorry, must enter 'h' or 's'."
    end
    break if answer == 's'

    player_cards.append(cards.pop)
  end

  if busted?(player_cards)
    puts "You went bust with a #{player_cards.last.last}"
  else
    puts "You chose to stay!"
  end

  puts "Dealer's turn..."
  sleep(2)

  loop do
    break if total(dealer_cards) >= 17 ||
             busted?(dealer_cards) ||
             busted?(player_cards)

    puts 'Dealer hits'
    dealer_cards.append(cards.pop)
    display_round(player_cards, dealer_cards, true)
    sleep(5)
  end

  if busted?(dealer_cards)
    puts "Dealer went bust with a #{dealer_cards.last.last}"
  else
    puts "Dealer chose to stay!"
  end

  puts call_winner(player_cards, dealer_cards)

  break unless play_again?
end
