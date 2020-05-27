def bubble_sort!(array)
  loop do
    swapped = false

    0.upto(array.size - 2) do |index|
      if array[index] > array[index + 1]
        array[index], array[index + 1] = array[index + 1], array[index]
        swapped = true
      end
    end

    break if swapped == false
  end
end
