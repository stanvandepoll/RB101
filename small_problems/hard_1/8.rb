def merge_sort(array)
  size = array.size
  return array if size == 1

  middle = size / 2
  left_array = array[0...middle]
  right_array = array[middle...size]
  sorted_left = merge_sort(left_array)
  sorted_right = merge_sort(right_array)

  merge(sorted_left, sorted_right)
end

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
