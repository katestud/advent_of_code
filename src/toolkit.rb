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

# Generates a grid (array of arrays) of a given size, with the given placeholder
def grid(size, placeholder)
  grid = [Array.new(size, placeholder)]
  (size-1).times { grid <<  Array.new(size, placeholder) }
  grid
end
