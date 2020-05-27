def swapcase(string)
  characters = string.chars.map do |char|
    if char.match(/[a-z]/)
      char.upcase
    elsif char.match(/[A-Z]/)
      char.downcase
    else
      char
    end
  end
  characters.join
end
