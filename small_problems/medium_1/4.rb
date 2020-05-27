def switch_lights(number_of_lights)
  lights = Array.new(number_of_lights) { |_ind| false }

  1.upto(number_of_lights) do |round|
    lights.each_with_index do |light, index|
      lights[index] = (index + 1) % round == 0 ? !light : light
    end
  end

  on_lights = []
  lights.each_with_index do |on, index|
    on_lights << (index + 1) if on
  end
  on_lights
end
