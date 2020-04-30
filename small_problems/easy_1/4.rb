=begin

  Write a method that counts the number of occurrences of each element in a
  given array. The words in the array are case-sensitive: 'suv' != 'SUV'. `
  Once counted, print each element alongside the number of occurrences.

  Example:
  input:
    vehicles = [
      'car', 'car', 'truck', 'car', 'SUV', 'truck',
      'motorcycle', 'motorcycle', 'car', 'truck'
    ]

    count_occurrences(vehicles)

  output:
    car => 4
    truck => 3
    SUV => 1
    motorcycle => 2

  Problem:
  input: array of strings
  output: hash with string keys and integer values
  keys are unique and from occurences. value is total number of accurences.
  occurences are case-sensitive.

  Examples:
  - given example
  - ['car', 'Car', 'Car', 'caR'] => { 'car' => 1, 'Car' => 2, 'caR' => 1 }
  - [] => {}
  - 'invalid input' => puts 'Invalid input'

  Data structure:
  Use a hash to count all occurences

  Algorithm:
  loop through input array.
  - add 1 to value for that string key in the output hash
  print output hash
=end

def count_occurrences(occurences)
  return puts 'Invalid input' unless occurences.instance_of? Array

  occurences = occurences.map(&:downcase)
  counts = {}
  occurences.each do |occurence|
    if counts[occurence].nil?
      counts[occurence] = 1
    else
      counts[occurence] += 1
    end
  end

  counts.each do |element, count|
    puts "#{element} => #{count}"
  end
end
