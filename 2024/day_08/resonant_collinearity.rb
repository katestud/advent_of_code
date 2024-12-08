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
    @antinodes = Set.new
    @antenna_positions.each do |_, positions|
      positions.each do |pos|
        positions.each do |next_pos|
          next if pos == next_pos
          x, y = pos
          nx, ny = next_pos
          x_diff = x - nx
          y_diff = y - ny
          node_1 = [x + x_diff, y + y_diff]
          @antinodes << node_1 if within_bounds?(node_1)
          node_2 = [nx - x_diff, ny - y_diff]
          @antinodes << node_2 if within_bounds?(node_2)
        end
      end
    end
    @antinodes.size
  end

  def execute_two
    @antenna_positions.length
  end

  private

  def within_bounds?(pos)
    pos.all? { |i| i >= 0 && i < @grid_size }
  end
end
