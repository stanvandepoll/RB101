SQMETERS_TO_SQFEET = 10.7639

puts "Enter the length of the room in meters:"
length = gets.chomp.to_f
puts "Enter the width of the room in meters:"
width = gets.chomp.to_f

area = {}
area[:sqm] = length * width
area[:sqft] = area[:sqm] * SQMETERS_TO_SQFEET

puts "The area of the room is #{area[:sqm]} square meters "\
     "(#{format('%<area>.2f', area: area[:sqft])} square feet)."
