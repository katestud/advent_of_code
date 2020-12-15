puzzle_input = [9,12,1,4,17,0,18]
test_input = [0,3,6]

# If that was the first time the number has been spoken, the current player says 0.
# Otherwise, the number had been spoken before; the current player announces how many turns apart the number is from when it was previously spoken.


def find_num(input)
  num_positions = Hash.new { |h, k| h[k] = [] }
  nums = []

  input.each_with_index do |val, index|
    nums << val
    num_positions[val].unshift(index)
  end

  until nums.length >= 30000000
    last = nums.last
    current = nums.length
    positions = num_positions[last]

    if positions && positions.length > 1
      val = positions[0] - positions[1]
    else
      val = 0
    end
    nums << val
    num_positions[val].unshift(current)
  end
  nums.last
end

puts "TEST INPUT"
puts find_num(test_input)

puts "INPUT"
puts find_num(puzzle_input)
