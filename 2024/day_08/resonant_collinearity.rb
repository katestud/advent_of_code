require_relative "../../src/toolkit"

class ResonantCollinearity

  def initialize(file_name = "input.txt")
    @antenna_positions = Hash.new { |h, k| h[k] = [] }
    input = File.readlines(file_name, chomp: true).map { |r| r.each_char.to_a }
    @grid_size = input.size

    input.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        case column
        when "."
          next
        else
          @antenna_positions[column] << [row_index, column_index]
        end
      end
    end
  end

  def execute_one
    execute
  end

  def execute_two
    execute(true)
  end

  private

  def execute(with_resonance = false)
    antinodes = Set.new
    @antenna_positions.each do |_, positions|
      positions.each do |pos|
        antinodes.add(pos) if with_resonance
        positions.each do |next_pos|
          find_antinodes(pos, next_pos, with_resonance).each { |n| antinodes.add(n) }
        end
      end
    end
    antinodes.size
  end

  def within_bounds?(pos)
    pos.all? { |i| i >= 0 && i < @grid_size }
  end

  def find_antinodes(pos1, pos2, resonant = false)
    return [] if pos1 == pos2
    x, y = pos1
    nx, ny = pos2
    x_diff = x - nx
    y_diff = y - ny
    node_1 = [x + x_diff, y + y_diff]
    node_2 = [nx - x_diff, ny - y_diff]
    if resonant
      nodes = []
      while within_bounds?(node_1)
        nodes << node_1
        node_1 = [node_1[0] + x_diff, node_1[1] + y_diff]
      end
      while within_bounds?(node_2)
        nodes <<  node_2
        node_2 = [node_2[0] - x_diff, node_2[1] - y_diff]
      end
      nodes
    else
      [node_1, node_2].select { |n| within_bounds?(n) }
    end
  end
end
