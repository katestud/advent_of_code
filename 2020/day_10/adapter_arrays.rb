input = File.readlines("input.txt").map(&:to_i)

input << 0 # to account for starting output

diffs = Hash.new(0)
input.sort.each_cons(2) do |adapter, next_adapter|
  diff = next_adapter - adapter
  diffs[next_adapter - adapter] += 1
end

diffs[3] += 1 # to account for your device

puts diffs[1] * diffs[3]
