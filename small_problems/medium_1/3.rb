def rotate_array(array)
  array = array.dup
  first_item = array.shift
  array << first_item
end

def rotate_rightmost_digits(number, extent)
  all_digits = number.to_s.chars
  all_digits[-extent..-1] = rotate_array(all_digits[-extent..-1])
  all_digits.join.to_i
end

def max_rotation(integer)
  integer_length = integer.to_s.length

  (1..integer_length).reverse_each do |extent|
    integer = rotate_rightmost_digits(integer, extent)
  end
  integer
end
