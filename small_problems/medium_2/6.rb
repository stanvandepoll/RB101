def triangle(angle1, angle2, angle3)
  angles = [angle1, angle2, angle3]
  return :invalid unless valid_triangle?(angles)

  if angles.any? { |angle| angle > 90 }
    :obtuse
  elsif angles.any? { |angle| angle == 90 }
    :right
  else
    :acute
  end
end

def valid_triangle?(angles)
  angles.sum == 180 && angles.all?(&:positive?)
end
