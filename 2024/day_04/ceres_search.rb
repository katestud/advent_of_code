require_relative "../../src/toolkit"

class CeresSearch

  def initialize(file_name = "input.txt")
    @grid = File.readlines(file_name, chomp: true).map { |l| l.each_char.to_a }
    @grid_size = @grid.length
  end

  def execute_one
    found = 0
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next unless column == "X"
        pos = [row_index, column_index]
        possible_directions.each do |direction|
          next_step = valid_next_step(pos, direction, @grid_size)
          next unless next_step && @grid[next_step[0]][next_step[1]] == "M"
          next_next = valid_next_step(next_step, direction, @grid_size)
          next unless next_next && @grid[next_next[0]][next_next[1]] == "A"
          third_next = valid_next_step(next_next, direction, @grid_size)
          next unless third_next && @grid[third_next[0]][third_next[1]] == "S"
          found += 1
        end
      end
    end
    found
  end

  def execute_two
    @grid.length
  end

  private

  def possible_directions
    [-1, 0, 1].product([-1, 0, 1])
  end

  def valid_next_step(pos, direction, grid_size)
    x,y = pos
    dx, dy = direction
    adj_x = x + dx
    adj_y = y + dy
    return nil if adj_x < 0
    return nil if adj_y < 0
    if grid_size
      return nil if adj_x >= grid_size
      return nil if adj_y >= grid_size
    end
    [adj_x, adj_y]
  end
end
