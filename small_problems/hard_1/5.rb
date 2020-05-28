def rotate(matrix, degrees = 90)
  degrees = degrees % 360
  rotations = degrees / 90

  rotations.times do
    matrix = rotate90(matrix)
  end

  matrix
end

def rotate90(matrix)
  matrix = transpose(matrix)
  matrix.map(&:reverse)
end

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

### TESTS

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2
