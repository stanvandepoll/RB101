require 'pry'

def prompt(message)
  puts "=> #{message}"
end

def get_variable(var_name:, validation:)
  prompt("Please enter the #{var_name}:")

  received_var = ''
  loop do
    received_var = gets.chomp

    if send(validation, received_var) && received_var.to_f >= 0
      break
    else
      prompt('Please enter a positive number.')
    end
  end

  received_var
end

def float?(input)
  /\d/.match(input) && /^\d*\.?\d*$/.match(input)
end

def integer?(input)
  /^\d+$/.match(input)
end

def monthly_payment(amount:, interest_rate:, years:)
  annual_interest_rate = interest_rate.to_f() / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years.to_i() * 12

  amount.to_f() *
    (monthly_interest_rate /
    (1 - (1 + monthly_interest_rate)**(-months)))
end

def wants_to_continue?
  prompt("Would you like to make another calculation? 'y' to repeat")
  answer = gets.chomp

  answer.downcase().start_with?('y')
end

# Start of program execution:
prompt 'Welcome to the Loan Calculator'

loop do
  amount = get_variable(var_name: 'loan amount', validation: 'float?')
  interest_rate = get_variable(var_name: 'interest_rate', validation: 'float?')
  years = get_variable(var_name: 'loan duration (in years)',
                       validation: 'integer?')

  monthly_payment = monthly_payment(amount: amount,
                                    interest_rate: interest_rate,
                                    years: years)

  formatted_payment = format('%02.2<payment>f', payment: monthly_payment)
  prompt("The monthly payment will be: €#{formatted_payment}")

  break unless wants_to_continue?
end

prompt("Thank you for using the Loan Calculator!")
prompt("Good bye!")
