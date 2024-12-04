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
        [-1, 0, 1].product([-1, 0, 1]).each do |direction|
          next_step = valid_next_step(pos, direction, @grid_size)
          next unless next_step && @grid.dig(*next_step) == "M"
          next_next = valid_next_step(next_step, direction, @grid_size)
          next unless next_next && @grid.dig(*next_next) == "A"
          third_next = valid_next_step(next_next, direction, @grid_size)
          next unless third_next && @grid.dig(*third_next) == "S"
          found += 1
        end
      end
    end
    found
  end

  def execute_two
    found = 0
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next unless column == "A"
        pos = [row_index, column_index]
        match = [
          [[-1, -1],[1,1]],
          [[-1, 1], [1, -1]]
        ].all? do |pair|
          vals = pair.map do |next_pos|
            next_step = valid_next_step(pos, next_pos, @grid_size)
            if next_step
              @grid.dig(*next_step)
            else
              ""
            end
          end
          vals.sort == ["M", "S"]
        end
        found += 1 if match
      end
    end
    found
  end

  private

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
