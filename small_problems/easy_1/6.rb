=begin

  Write a method that takes one argument, a string containing one or more words,
  and returns the given string with words that contain five or more characters
  reversed. Each string will consist of only letters and spaces. Spaces should
  be included only when more than one word is present.

  examples:
  puts reverse_words('Professional')          # => lanoisseforP
  puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
  puts reverse_words('Launch School')         # => hcnuaL loohcS

  Problem:
  input: string containing one or more words
  output: string
    - each word that has more than 4 characters should be reversed in the output

  Examples:
  - see given

  Data structure:
  - convert to array

  Algorithm:
  - loop through words.
  - if length > 4, reverse word. else just copy.
=end

def reverse_words(sentence)
  sentence.split(' ').map do |word|
    word.length > 4 ? word.reverse : word
  end.join(' ')
end
