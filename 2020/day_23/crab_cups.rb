test_input = [3,8,9,1,2,5,4,6,7]
input = [1,5,8,9,3,7,4,6,2]

additional_cups = (10..1000000).to_a

cups = test_input.dup #+ additional_cups.dup

100.times do
  current = cups.first
  cups.rotate!

  hold = cups.shift(3)

  destination = nil
  if cups.any? { |i| i < current }
    destination = cups.select { |i| i < current }.max
  else
    destination = cups.max
  end

  index = cups.index(destination)
  cups.insert(index + 1, *hold)
end

one_index = cups.index(1)
cups.rotate!(one_index)

puts cups.take(10).join(",")
