DIGIT_HASH = {
  'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
  'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
}.freeze

def words_to_digits(words)
  DIGIT_HASH.each do |word, number|
    words.gsub!(/\b#{word}\b/, number)
  end
  words
end

def alt_words_to_digits(words)
  words.split.map do |word|
    word_to_digit(word)
  end.join(' ')
end

def word_to_digit(word)
  word_only_letters = word.gsub(/[^a-zA-Z]/, '')
  return word unless DIGIT_HASH.keys.include?(word_only_letters)

  word.gsub(word_only_letters, DIGIT_HASH[word_only_letters])
end