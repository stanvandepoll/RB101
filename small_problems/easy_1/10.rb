=begin

Write a method that takes two arguments, a positive integer and a boolean,
and calculates the bonus for a given salary. If the boolean is true, the
bonus should be half of the salary. If the boolean is false, the bonus should
be 0.

Problem:
input: positive integer and boolean
  - salary, and if bonus should be given
output: integer, calculated bonus

examples:
calculate_bonus(2800, true) => 1400
calculate_bonus(1000, false) => 0
calculate_bonus(50000, true) => 25000

Data structure:
nothing more needed

Algorithm:
- If boolean is false return 0
- return salary / 2

=end

def calculate_bonus(salary, deserves_bonus)
  return 0 unless deserves_bonus

  salary / 2
end
