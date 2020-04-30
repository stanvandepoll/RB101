=begin

  Write a method that takes one integer argument, which may be positive,
  negative, or zero. This method returns true if the number's absolute
  value is odd. You may assume that the argument is a valid integer value.

  Problem:
  Input: 1 integer
    - positive, negative or zero.
  Output: boolean
    - true if x.abs is odd

  Examples:
  puts is_odd?(2)    # => false
  puts is_odd?(5)    # => true
  puts is_odd?(-17)  # => true
  puts is_odd?(-8)   # => false
  puts is_odd?(0)    # => false
  puts is_odd?(7)    # => true

  data:

  alg:
    - make input absolute
    - check if odd

  further exploration: use remainder instead of modulus
=end

def is_odd?(integer)
  integer.abs.remainder(2) == 1
end
