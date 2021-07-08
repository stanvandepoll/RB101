def diamond(total_width)
  sides = total_width / 2
  sides.downto(1) do |white_width|
    puts line(total_width, white_width)
  end
  0.upto(sides) do |white_width|
    puts line(total_width, white_width)
  end
  nil
end

def line(total_width, white_width)
  (' ' * white_width) + ('*' * (total_width - (2 * white_width))) + (' ' * white_width)
end

puts diamond(9)