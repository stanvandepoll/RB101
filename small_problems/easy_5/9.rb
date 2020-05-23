def crunch(text)
  crunch_text = ''
  text.each_char do |char|
    crunch_text << char unless crunch_text[-1] == char
  end
  crunch_text
end
