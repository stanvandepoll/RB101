DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

def string_to_integer(string)
  digits = string.chars.map { |char| DIGITS[char] }

  value = 0
  digits.each { |digit| value = 10 * value + digit }
  value
end

def string_to_signed_integer(string)
  negative = false
  string = case string[0]
           when '-'
             negative = true
             string[1..-1]
           when '+'
             string[1..-1]
           else
             string
           end
  integer = string_to_integer(string)
  negative ? -integer : integer
end
