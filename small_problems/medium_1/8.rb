def fibonacci(nth)
  return 1 if nth < 3

  fibonacci(nth - 1) + fibonacci(nth - 2)
end
