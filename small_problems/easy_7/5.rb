def staggered_case(string)
  index = 0
  string.chars.map do |char|
    index += 1
    index.odd? ? char.upcase : char.downcase
  end.join
end
