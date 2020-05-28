def transpose!(matrix)
  (0..1).each do |row|
    ((row + 1)..2).each do |column|
      matrix[row][column], matrix[column][row] =
        matrix[column][row], matrix[row][column]
    end
  end
  matrix
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose!(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix.object_id == new_matrix.object_id
