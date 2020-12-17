class Row < Array
  def self.build(size)
    new(size) { "." }
  end

  def expand
    self.prepend(".")
    self << "."
    self
  end
end
class Layer < Array
  def self.build(size)
    new(size) { Row.build(size).dup  }
  end

  def expand
    self.map!(&:expand)
    row = Row.build(length + 2)
    self.prepend row.dup
    self << row.dup
    self
  end
end

class Cube < Array
  def self.build(size)
    new(size - 2) { Layer.build(size).dup }
  end

  def expand
    size = length + 2
    self.map!(&:expand)
    self.prepend Layer.build(size)
    self << Layer.build(size)
    self
  end

  def length
    self.first.size
  end
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
  start_cube.expand
  size = start_cube.length

  new_cube = Cube.build(size)

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

input = File.readlines("input.txt", chomp: true).to_a.map { |line| Row.new(line.split("")) }

new_cube = Cube.new([Layer.new(input)])

6.times do
  new_cube = iterate_over_cube(new_cube)
end

puts new_cube.flatten.count("#")
