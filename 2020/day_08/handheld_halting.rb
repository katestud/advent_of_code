require 'set'

input = File.readlines("input.txt").to_a

accumulator = 0
executed_instructions = Set.new
index = 0

while executed_instructions.add?(index)
  instruction, num = input[index].split
  num = num.to_i
  case instruction
  when "nop"
    index += 1
  when "jmp"
    index += num
  when "acc"
    accumulator += num
    index += 1
  end
end

puts accumulator
