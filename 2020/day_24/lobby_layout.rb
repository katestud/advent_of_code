require 'strscan'

instructions = File.readlines("input.txt", chomp: true)

grid = []
row = Array.new(1000, "0")
1000.times do
  row = 1000.times.map {"0"}
  grid << row.dup
end

origin = [500, 500]
black_positions = []

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
  black_positions << pos if val == "X"
  grid[pos[0]][pos[1]] = val
end

puts "COUNT OF BLACK TILES:"
puts grid.map { |row| row.count("X") }.sum

def find_valid_coordinates(position)
  coordinates = [[0, 1], [0, -1], [-1, 1], [-1, 0], [1, 0], [1, -1]]
  coordinates.map do |coord|
    [coord, position].transpose.map(&:sum)
  end.select do |coord|
    coord.all? { |i| i >= 0 && i < 1000 }
  end
end

100.times do |i|
  start_row_index = black_positions.map(&:first).min - 1
  end_row_index = black_positions.map(&:first).max + 1

  start_cell_index = black_positions.map(&:last).min - 1
  end_cell_index = black_positions.map(&:last).max + 1

  black_positions = []
  new_grid = grid.clone.map(&:clone)
  grid.each_with_index do |row, row_index|
    next if row_index < start_row_index || row_index > end_row_index

    row.each_with_index do |cell, cell_index|
      next if cell_index < start_cell_index || cell_index > end_cell_index
      neighbor_coords = find_valid_coordinates([row_index, cell_index])
      neighbor_count = neighbor_coords.map { |coords| grid.dig(*coords) }.count("X")
      if cell == "X"
        if neighbor_count == 0 || neighbor_count > 2
          new_grid[row_index][cell_index] = "0"
        else
          black_positions << [row_index, cell_index]
        end
      else
        if neighbor_count == 2
          new_grid[row_index][cell_index] = "X"
          black_positions << [row_index, cell_index]
        end
      end
    end
  end

  grid = new_grid
end

puts "COUNT OF BLACK TILES:"
puts grid.map { |row| row.count("X") }.sum
