def calculate_value(value)
  instructions = value.split
  val = eval(instructions.first)
  instructions.each_cons(2) do |row, next_row|
    next unless row =~ /[\+\-\*\/]/
    val = val.send(row, eval(next_row))
  end
  val
end

input = File.readlines("input.txt", chomp: true).map do |line|
  while line =~ /\)/
    line.gsub!(/\([^()]*?\)/) do |match|
      calculate_value(match[1..-2])
    end
  end
  calculate_value(line)
end

puts input.sum
