def rotate_array(array)
  array = array.dup
  first_item = array.shift
  array << first_item
end
