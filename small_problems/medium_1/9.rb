def fibonacci(nth)
  fib_sequence = [0, 1, 1]

  3.upto(nth) do |turn|
    fib_sequence[turn] = fib_sequence[turn - 1] + fib_sequence[turn - 2]
  end

  fib_sequence[nth]
end
