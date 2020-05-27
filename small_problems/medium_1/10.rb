def fibonacci_last(nth)
  prev, last = [1, 1]
  3.upto(nth) do
    prev, last = [last, (prev + last) % 10]
  end

  last
end
