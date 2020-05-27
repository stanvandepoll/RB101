def triangle(side1, side2, side3)
  return :invalid unless valid_triangle?(side1, side2, side3)

  if side1 == side2 && side2 == side3
    :equilateral
  elsif side1 != side2 && side2 != side3 && side3 != side1
    :scalene
  else
    :isosceles
  end
end

def valid_triangle?(side1, side2, side3)
  sides = [side1, side2, side3]
  return false if sides.any? { |side| side <= 0 }

  longest = sides.max
  return false if 2 * longest > sides.sum

  true
end
