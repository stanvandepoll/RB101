=begin

  Write a method that takes two arguments, a string and a positive integer,
  and prints the string as many times as the integer indicates.

  example repeat('Hello', 3)
  => Hello
     Hello
     Hello

  Problem:
  Input 1 string (s), 1 integer (x).
  Output string s printed x times.

  Examples:
  repeat('Hello', 0) => nothing printed
  repeat('Hello', 'Steve') => print 'Invalid input'
  given example

  Data structure:
  Use already present data, no need for new structure.

  Algorithm:
  - Check input, return print 'Invalid input' if fails.
  - loop x times for print string

  Code:
=end

def repeat(string, repeats)
  return puts 'Invalid input' unless string.instance_of?(String) &&
                                     repeats.instance_of?(Integer)

  repeats.times do
    puts string
  end
end
