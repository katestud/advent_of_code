require 'set'

input = File.readlines("input.txt").to_a

def run_simulation(input)
  accumulator = 0
  executed_instructions = Set.new
  index = 0
  success = false

  while executed_instructions.add?(index)
    if index >= input.length
      success = true
      break
    end
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
  [success, accumulator]
end

success, accumulator = run_simulation(input)

puts "Part one should exit when accumulator is #{accumulator}"

input.each_with_index do |row, index|
  next if row =~ /acc/
  dup = input.dup
  current = dup[index]
  if current =~ /nop/
    dup[index] = current.sub("nop", "jmp")
  elsif current =~ /jmp/
    dup[index] = current.sub("jmp", "nop")
  else
    raise "Boom"
  end
  success, accumulator = run_simulation(dup)
  if success
    puts "Swapped value was #{current} at index #{index}"
    puts "Accumulator would end at #{accumulator}"
    break
  end
end
