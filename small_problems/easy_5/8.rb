NUMBER_WORDS = %w(zero one two three four
                  five six seven eight nine
                  ten eleven twelve thirteen fourteen
                  fifteen sixteen seventeen eighteen nineteen)

def alphabetic_number_sort(numbers)
  numbers.sort do |a, b|
    NUMBER_WORDS[a] <=> NUMBER_WORDS[b]
  end
end
