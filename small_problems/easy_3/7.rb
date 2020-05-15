def oddities(array, start = 0, step = 2)
  odd_elements = []
  start.step(array.length - 1, step) do |index|
    odd_elements << array[index]
  end
  odd_elements
end
