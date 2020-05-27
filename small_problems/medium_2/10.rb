def sum_square_difference(num)
  sum = (1..num).sum
  sum_of_squares = (1..num).reduce { |total, iter| total + iter**2 }

  sum**2 - sum_of_squares
end
