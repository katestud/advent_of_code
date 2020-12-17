def build_empty_layer(size)
  row = Array.new(size) { "." }
  Array.new(size) { row.dup  }
end

def expand_layer(layer)
  result = layer.map do |row|
    row.prepend(".")
    row << "."
  end
  row = Array.new(layer.length + 2) { "." }
  result.prepend row.dup
  result << row.dup
end

def build_cube(cube)
  size = cube.first.size + 2
  cube = cube.map do |layer|
    expand_layer(layer)
  end
  cube.prepend build_empty_layer(size)
  cube << build_empty_layer(size)
end

# If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active. Otherwise, the cube becomes inactive.
# If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active. Otherwise, the cube remains inactive.

def neighbor_indexes(x, y, z, length)
  [
    [x + 1, y, z],
    [x + 1, y + 1, z + 1],
    [x + 1, y - 1, z + 1],
    [x + 1, y + 1, z - 1],
    [x + 1, y - 1, z - 1],
    [x + 1, y + 1, z],
    [x + 1, y - 1, z],
    [x + 1, y, z + 1],
    [x + 1, y, z - 1],

    [x - 1, y, z],
    [x - 1, y + 1, z + 1],
    [x - 1, y - 1, z + 1],
    [x - 1, y + 1, z - 1],
    [x - 1, y - 1, z - 1],
    [x - 1, y + 1, z],
    [x - 1, y - 1, z],
    [x - 1, y, z + 1],
    [x - 1, y, z - 1],

    [x, y + 1, z + 1],
    [x, y - 1, z + 1],
    [x, y + 1, z - 1],
    [x, y - 1, z - 1],

    [x, y, z + 1],
    [x, y, z - 1],

    [x, y - 1, z],
    [x, y + 1, z],
  ].uniq.select do |indexes|
    indexes.all? { |i| i >= 0 } && indexes.all? { |i| i < length }
  end
end

def iterate_over_cube(start_cube)
  start_cube = build_cube(start_cube)
  size = start_cube.first.length

  new_cube = Array.new(size - 2) { Array.new(size) { Array.new(size) } }

  start_cube.each_with_index do |layer, layer_index|
    layer.each_with_index do |row, row_index|
      row.each_with_index do |char, char_index|

        neighbor_indexes = neighbor_indexes(layer_index, row_index, char_index, size)
        neighbors = neighbor_indexes.map do |neighbor|
          start_cube.dig(*neighbor)
        end
        active_neighbors = neighbors.compact.count("#")

        val = if char == "#"
          if (2..3).cover?(active_neighbors)
            "#"
          else
            "."
          end
        else
          if active_neighbors == 3
            "#"
          else
            "."
          end
        end
        new_cube[layer_index][row_index][char_index] = val
      end
    end
  end
  new_cube
end

input = File.readlines("input.txt", chomp: true).to_a.map { |line| line.split("") }

new_cube = [input]

6.times do
  new_cube = iterate_over_cube(new_cube)

  new_cube.each do |layer|
    layer.each do |row|
      puts row.join
    end
    puts "       "
  end
end


puts new_cube.flatten.count("#")
