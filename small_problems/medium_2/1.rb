text = File.read('pg84.txt')
sentences = text.split(/(\.|\?|!)/).each_slice(2).map(&:join)
largest_sentence = sentences.max_by { |sentence| sentence.split.size }
number_of_words = largest_sentence.split.size

puts "Largest sentence is:
#{largest_sentence}
-----
and has #{number_of_words} words"
