def staggered_case(string, ignore_numbers: true)
  index = 0
  string.chars.map do |char|
    if ignore_numbers
      next(char) unless char =~ /[a-zA-Z]/
    end

    index += 1
    index.odd? ? char.upcase : char.downcase
  end.join
end
