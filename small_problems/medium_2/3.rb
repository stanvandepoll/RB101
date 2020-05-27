def letter_percentages(string)
  total = string.length
  uppercase = string.count('A-Z').to_f
  lowercase = string.count('a-z').to_f
  neither = (string.length - uppercase - lowercase).to_f

  { lowercase: percentize(lowercase, total),
    uppercase: percentize(uppercase, total),
    neither: percentize(neither, total) }
end

def percentize(amount, total)
  ((amount / total) * 100).round(2)
end
