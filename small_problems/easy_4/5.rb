def multisum(max_value)
  multiples = (0..max_value).select do |num|
    num % 3 == 0 || num % 5 == 0
  end

  multiples.sum
end
