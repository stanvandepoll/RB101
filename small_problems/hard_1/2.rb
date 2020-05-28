def star(length)
  max_from_middle = length / 2

  max_from_middle.downto(1) do |from_middle|
    puts regular_line(from_middle, max_from_middle)
  end
  puts middle_line(length)
  1.upto(max_from_middle) do |from_middle|
    puts regular_line(from_middle, max_from_middle)
  end
end

def middle_line(length)
  '*' * length
end

def regular_line(from_middle, max_from_middle)
  around = ' ' * (max_from_middle - from_middle)
  between = ' ' * (from_middle - 1)
  "#{around}*#{between}*#{between}*#{around}"
end
