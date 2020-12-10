input = File.readlines("input.txt").map(&:to_i).sort

input.unshift(0) # to account for starting output

diffs = Hash.new(0)
input.each_cons(2) do |adapter, next_adapter|
  diff = next_adapter - adapter
  diffs[next_adapter - adapter] += 1
end

diffs[3] += 1 # to account for your device

puts "Product of Ones and Threes:"
puts diffs[1] * diffs[3]

# Loosely inspired by tribonacci numbers
possibilities = [1, 1, 1, 2, 4, 7, 11, 21, 39, 71, 131, 241, 443, 815]

total_possibilities = input.chunk_while do |adapter, next_adapter|
  next_adapter - adapter == 1
end.map do |chunk|
  possibilities[chunk.length]
end.inject(:*)

puts "Total Possibilities:"
puts total_possibilities
