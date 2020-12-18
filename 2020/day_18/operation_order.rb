def calculate_value(value)
  instructions = value.split
  val = eval(instructions.first)
  instructions.each_cons(2) do |row, next_row|
    next unless row =~ /[\+\-\*\/]/
    val = val.send(row, eval(next_row))
  end
  val
end

def calculate_value_precedence(value)
  while value =~ /\+/
    value.sub!(/(\d+)([\+])(\d+)/) do |_|
      match = Regexp.last_match
      match[1].to_i.send(match[2], match[3].to_i).to_s
    end
  end
  calculate_value(value)
end

input = File.readlines("input.txt", chomp: true)

## Part 1
part1 = input.map do |line|
  while line =~ /\)/
    line.gsub!(/\([^()]*?\)/) do |match|
      calculate_value(match[1..-2])
    end
  end
  calculate_value(line)
end

puts "Part 1:"
puts part1.sum

## Part 2
part2 = File.readlines("input.txt", chomp: true).map do |line|
  line.gsub!(/\s+/, "")
  while line =~ /\)/
    line.gsub!(/\([^()]*?\)/) do |match|
      calculate_value_precedence(match[1..-2])
    end
  end
  calculate_value_precedence(line)
end

puts "Part 2:"
puts part2.sum
