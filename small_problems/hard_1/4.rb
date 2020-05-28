def transpose(matrix)
  cols = matrix.first.size
  rows = matrix.size
  result = []
  (0...cols).each do |column_index|
    new_row = (0...rows).map { |row_index| matrix[row_index][column_index] }
    result << new_row
  end
  result
end
