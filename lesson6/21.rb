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

cards = deck.shuffle
player_cards = [cards.pop, cards.pop]
dealer_cards = [cards.pop, cards.pop]

loop do
  display_round(player_cards, dealer_cards)
  puts "hit or stay?"
  answer = gets.chomp
  break if answer == 'stay' || busted?
end
