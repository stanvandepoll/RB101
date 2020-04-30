def stringy(length, start = 1)
  other = start.zero? ? 1 : 0
  output = []

  length.times do |index|
    output << (index.even? ? start : other)
  end
  output.join
end
