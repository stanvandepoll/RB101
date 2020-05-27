=begin
Problem:

Write a method that returns the number of Friday the 13ths in the
year given by an argument. You may assume that the year is greater
than 1752 (when the United Kingdom adopted the modern Gregorian Calendar)
and that it will remain in use for the foreseeable future.

Find number of friday the 13ths in a given year.

Examples:

friday_13th(2015) == 3
friday_13th(1986) == 1
friday_13th(2019) == 2

Data structures:

use a 2d array that represents all dates and day names of a year.
  to create this array you need to
    know how long each months is --> array of integers
      depends on leap year or not
    know the starting day name

Algo:

=end

def friday_13th(year)
  date_day_combs = initialize_date_day_combinations(year)
  date_day_combs.select { |date, day| date == 13 && day == 'fri' }.size
end

def initialize_date_day_combinations(year)
  month_lengths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  month_lengths[1] += 1 if leap_year?(year)
  day_names = %w[fri sat sun mon tue wed thu]
  day_names.rotate!(initial_day(year))

  date_day_combinations = []
  month_lengths.each do |days_in_month|
    1.upto(days_in_month) do |date|
      date_day_combinations << [date, day_names.rotate!.first]
    end
  end

  date_day_combinations
end

def initial_day(year)
  last_two = year.to_s[-2..-1].to_i
  divided = last_two / 4
  adjusted = divided + 2
  adjusted -= 1 if leap_year?(year)
  adjusted += gregorian_adjustment(year)
  adjusted += last_two
  adjusted % 7
end

def leap_year?(year)
  if year % 400 == 0
    true
  elsif year % 100 == 0
    false
  else
    year % 4 == 0
  end
end

def gregorian_adjustment(year)
  case year % 400
  when 0..99
    6
  when 100..199
    4
  when 200..299
    2
  else
    0
  end
end
