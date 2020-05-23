def running_total(array)
  array.inject([0]) do |collector, value|
    collector.append(collector.last + value)
  end.slice(1, array.length)
end
