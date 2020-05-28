def merge(array1, array2)
  merged = []
  length = array1.length + array2.length
  index1 = 0
  index2 = 0

  length.times do
    remainder1 = array1.slice(index1, length)
    remainder2 = array2.slice(index2, length)
    if remainder1.empty?
      break merged.push(*remainder2)
    elsif remainder2.empty?
      break merged.push(*remainder1)
    elsif remainder1.first < remainder2.first
      merged << remainder1.first
      index1 += 1
    else
      merged << remainder2.first
      index2 += 1
    end
  end

  merged
end

p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]
