require 'strscan'

instructions = File.readlines("input.txt", chomp: true)

grid = []
row = Array.new(100, "0")
100.times { grid << row.dup }

origin = [50, 50]

instructions.each do |line|
  pos = origin.dup
  s = StringScanner.new(line)
  until s.eos?
    if s.scan(/e/)

      pos[1] += 1
    elsif s.scan(/w/)
      pos[1] -= 1
    elsif s.scan(/ne/)
      pos[0] -= 1
      pos[1] += 1
    elsif s.scan(/nw/)
      pos[0] -= 1
    elsif s.scan(/se/)
      pos[0] += 1
    elsif s.scan(/sw/)
      pos[0] += 1
      pos[1] -= 1
    else
      raise "Boom"
    end
  end

  val = grid.dig(pos[0], pos[1]) == "0" ? "X" : "0"
  grid[pos[0]][pos[1]] = val
end

puts "COUNT OF BLACK TILES:"
puts grid.map { |row| row.count("X") }.sum
