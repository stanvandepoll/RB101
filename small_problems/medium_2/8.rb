def featured(number)
  number += 1
  number += 1 until number.odd? && number % 7 == 0

  loop do
    number_chars = number.to_s.split('')
    return number if number_chars.uniq == number_chars

    number += 14
    break if number >= 9_876_543_210
  end

  'There is no possible number that fulfills those requirements.'
end
