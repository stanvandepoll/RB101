=begin

  Write a method that takes one argument, a positive integer, and returns the
  sum of its digits.

  examples:
  sum(23) => 5
  sum(496) => 19
  sum(123_456_789) => 45

  Problem:
  input: one positive integer
  output: one positive integer, sum of all digits

  examples: given

  Data structure:
  integer to string
  string to array of characters
  array of characters to array of integers
  integer output

  Algorithm:
  follows from data structure.

=end

def sum(integer)
  integer.to_s.split('').map(&:to_i).reduce(&:+)
end
