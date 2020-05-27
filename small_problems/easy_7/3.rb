def word_cap(string)
  string.split.map { |word| word.downcase.capitalize }.join(' ')
end
