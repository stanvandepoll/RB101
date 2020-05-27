def halvsies(array)
  middle = (array.size / 2.0).ceil
  first_half = array.slice!(0, middle)
  second_half = array
  [first_half, second_half]
end
