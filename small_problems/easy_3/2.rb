def prompt(message)
  puts "==> #{message}"
end

prompt("Enter the first number:")
first_number = gets.chomp.to_f
prompt("Enter the second number:")
second_number = gets.chomp.to_f

prompt("#{first_number} + #{second_number} = #{first_number + second_number}")
prompt("#{first_number} - #{second_number} = #{first_number - second_number}")
prompt("#{first_number} * #{second_number} = #{(first_number * second_number).round(2)}")
prompt("#{first_number} / #{second_number} = #{(first_number / second_number).round(2)}")
prompt("#{first_number} % #{second_number} = #{(first_number % second_number).round(2)}")
prompt("#{first_number} ** #{second_number} = #{(first_number**second_number).round(2)}")
