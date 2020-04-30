=begin

  Write a method that takes one argument, a positive integer, and returns a list
  of the digits in the number.

  Problem:
  input: 1 positive integer
  output: list of numbers

  examples:
  puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
  puts digit_list(7) == [7]                     # => true
  puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
  puts digit_list(444) == [4, 4, 4]             # => true

  data structure:
  convert integer to string
  split string into array

  algorithm:
  basically implied in data structure
=end

def digit_list(integer)
  integer.to_s.split('').map(&:to_i)
end
