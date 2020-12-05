binaries = File.readlines("input.txt").map do |line|
  line.gsub!(/[BR]/, "1")
  line.gsub!(/[FL]/, "0")
  line.to_i(2)
end

max = binaries.max
puts "The highest seat number is: #{max}"

num = max
loop do
  break unless binaries.include?(num)
  num -= 1
end

puts "Your seat number is: #{num}"
