require_relative "../../src/toolkit"

class GuardGavillant

  def initialize(file_name = "input.txt")
    @grid = File.readlines(file_name, chomp: true).map { |l| l.each_char.to_a }
    @grid_size = @grid.length
    @directions = [[-1, 0], [0, 1], [1, 0], [0, -1]].cycle
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |value, column_index|
        if value == "^"
          @start_pos = [row_index, column_index]
          break
        end
      end
    end
  end

  def execute_one
    visited = Set.new
    current_position = @start_pos
    visited.add(current_position)
    done = false
    @directions.each do |dir|
      break if done
      loop do
        next_step = next_step(current_position, dir)
        if next_step.nil?
          done = true
          break
        elsif @grid.dig(*next_step) == "#"
          break
        else
          x, y = next_step
          @grid[x][y] = "X"
          visited.add(next_step)
          current_position = next_step
        end
      end
    end

    visited.size
  end

  def execute_two
    @grid.length
  end

  private

  def next_step(pos, direction)
    x,y = pos
    dx, dy = direction
    adj_x = x + dx
    adj_y = y + dy
    return nil if adj_x < 0
    return nil if adj_y < 0
    return nil if adj_x >= @grid_size
    return nil if adj_y >= @grid_size
    [adj_x, adj_y]
  end
end
