# Reads a multi-line file, with each line split by given separator
def read_lines_with_separator(filename, separator = ",")
  File.readlines(filename, chomp: true).map { |line| line.split(separator) }
end

# Reads a multi-line file with an integer on each line, returns an Array of integers
def read_lines_of_integers(filename)
  File.readlines(filename, chomp: true).map { |line| line.to_i }
end

# Reads a one-line file with comma-separated integers, returns an Array of integers
def read_line_of_integers(filename)
  File.read(filename).split(",").map { |line| line.to_i }
end

def read_file_into_batches(filename)
  File.read(filename, chomp: true).split("\n\n").map { |b| b.split("\n") }
end

# Generates a grid (array of arrays) of a given size, with the given placeholder
def grid(size, placeholder)
  grid = [Array.new(size, placeholder)]
  (size-1).times { grid <<  Array.new(size, placeholder) }
  grid
end

# Given a position [x, y], returns an array of positions next to it, including # diagonals. Does not return positions with negative coordinates (which would
# be out of bounds). Optionally takes a grid size parameter to omit out of
# bounds positions
def adjacent_positions(pos, grid_size = nil)
  x,y = pos
  [-1, 0, 1].product([-1, 0, 1]).map do |dx, dy|
    adj_x = x + dx
    adj_y = y + dy
    next if adj_x < 0
    next if adj_y < 0
    if grid_size
      next if adj_x >= grid_size
      next if adj_y >= grid_size
    end
    [adj_x, adj_y]
  end.compact
end

# Given an array, returns a new array with unique pairs of items
def pairs(array)
  array.each_with_object([]).with_index do |(item, arr), index|
    array[index+1..-1].each do |next_item|
      arr << [item, next_item]
    end
  end
end


# Given two coordinates, calculates the manhattan distance between the two
def manhattan_distance(a, b)
  (0..a.size-1).reduce(0) do |sum, index|
    sum + (a[index] - b[index]).abs
  end
end

