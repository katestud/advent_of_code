require 'benchmark'

puzzle_input = [9,12,1,4,17,0,18]
test_input = [0,3,6]

# If that was the first time the number has been spoken, the current player says 0.
# Otherwise, the number had been spoken before; the current player announces how many turns apart the number is from when it was previously spoken.


def find_num(input)
  num_positions = Hash.new { |h, k| h[k] = [] }

  input.each_with_index do |val, index|
    num_positions[val].unshift(index)
  end

  current_index = input.length
  current_value = input.last

  until current_index >= 30000000
    positions = num_positions[current_value]

    if positions && positions.length > 1
      current_value = positions[0] - positions[1]
    else
      current_value = 0
    end
    num_positions[current_value].unshift(current_index)
    current_index += 1
  end
  current_value
end

# puts "TEST INPUT"
# puts find_num(test_input)

puts "INPUT"
puts Benchmark.measure { puts find_num(puzzle_input) }
