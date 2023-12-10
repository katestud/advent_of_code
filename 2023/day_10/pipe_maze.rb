require_relative "../../src/toolkit"

class PipeMaze

  DIRECTION = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
    @start_direction = :down
    @start_position = find_start
  end

  def execute_one
    @input.length
    current_direction = @start_direction
    current_position = @start_position
    traveled_positions = [current_position]
    while current_direction != :stop
      apply = DIRECTION[current_direction]
      current_position = [current_position[0] + apply[0], current_position[1] + apply[1]]
      traveled_positions << current_position
      value = @input[current_position[0]][current_position[1]]
      current_direction = find_next_direction(value, current_direction)
    end
    traveled_positions.size / 2
  end

  def execute_two
    @input.length
  end

  # | is a vertical pipe connecting north and south.
  # - is a horizontal pipe connecting east and west.
  # L is a 90-degree bend connecting north and east.
  # J is a 90-degree bend connecting north and west.
  # 7 is a 90-degree bend connecting south and west.
  # F is a 90-degree bend connecting south and east.
  # . is ground; there is no pipe in this tile.
  # S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.

  def find_next_direction(value, current_direction)
    error = "Incompatible: #{value}, direction: #{current_direction}"

    case value
    when "|"
      if current_direction == :up
        :up
      elsif current_direction == :down
        :down
      else
        raise error
      end
    when "-"
      if current_direction == :right
        :right
      elsif current_direction == :left
        :left
      else
        raise error
      end
    when "L"
      if current_direction == :down
        :right
      elsif current_direction == :left
        :up
      else
        raise error
      end
    when "J"
      if current_direction == :down
        :left
      elsif current_direction == :right
        :up
      else
        raise error
      end
    when "7"
      if current_direction == :right
        :down
      elsif current_direction == :up
        :left
      else
        raise error
      end
    when "F"
      if current_direction == :left
        :down
      elsif current_direction == :up
        :right
      else
        raise error
      end
    when "S"
      :stop
    else
      raise "Unprocessable character #{value}"
    end
  end

  def find_start
    y = @input.index {|l| l.include?("S")}
    x = @input[y].index("S")
    [y, x]
  end
end
