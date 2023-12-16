require_relative "../../src/toolkit"

class FloorIsLava

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one(start_dir: :right)
    traverse([0,0], start_dir)
  end

  def execute_two
    directions = Set.new
    max_index = @input.length - 1
    0.upto(max_index).each do |i|
      directions << [[0,i], :down]
      directions << [[i, 0], :right]
      directions << [[max_index, i], :up]
      directions << [[i, max_index], :left]
    end
    directions.map do |(pos, dir)|
      traverse(pos, dir)
    end.max
  end

  private

  def traverse(start_position, start_dir)
    energized_tiles = Set.new
    visited_with_direction = Set.new

    start = [start_position, start_dir]
    visited_with_direction.add(start)
    energized_tiles.add(start_position)
    current_beams = [[start_position, start_dir]]

    until current_beams.empty?
      new_beams = []

      current_beams.each do |(pos, direction)|
        new_pos = move(pos, direction)
        next unless valid_pos?(new_pos)
        energized_tiles.add(new_pos)
        new_directions(new_pos, direction).each do |dir|
          if visited_with_direction.add?([new_pos, dir])
            new_beams << [new_pos, dir]
          end
        end
      end

      current_beams = new_beams
    end

    energized_tiles.count
  end

  def move(pos, direction)
    case direction
    when :right
      [pos[0], pos[1] + 1]
    when :left
      [pos[0], pos[1] - 1]
    when :down
      [pos[0] + 1, pos[1]]
    when :up
      [pos[0] - 1, pos[1]]
    end
  end

  # If the beam encounters empty space (.), it continues in the same direction.
  # If the beam encounters a mirror (/ or \), the beam is reflected 90 degrees depending on the angle of the mirror. For instance, a rightward-moving beam that encounters a / mirror would continue upward in the mirror's column, while a rightward-moving beam that encounters a \ mirror would continue downward from the mirror's column.
  # If the beam encounters the pointy end of a splitter (| or -), the beam passes through the splitter as if the splitter were empty space. For instance, a rightward-moving beam that encounters a - splitter would continue in the same direction.
  # If the beam encounters the flat side of a splitter (| or -), the beam is split into two beams going in each of the two directions the splitter's pointy ends are pointing. For instance, a rightward-moving beam that encounters a | splitter would split into two beams: one that continues upward from the splitter's column and one that continues downward from the splitter's column.

  def new_directions(pos, direction)
    char = @input[pos[0]][pos[1]]
    case char
    when "."
      [direction]
    when "/"
      if direction == :right
        [:up]
      elsif direction == :left
        [:down]
      elsif direction == :up
        [:right]
      elsif direction == :down
        [:left]
      end
    when "\\"
      if direction == :right
        [:down]
      elsif direction == :left
        [:up]
      elsif direction == :up
        [:left]
      elsif direction == :down
        [:right]
      end
    when "-"
      if direction == :right
        [:right]
      elsif direction == :left
        [:left]
      elsif direction == :up
        [:right, :left]
      elsif direction == :down
        [:right, :left]
      end
    when "|"
      if direction == :right
        [:up, :down]
      elsif direction == :left
        [:up, :down]
      elsif direction == :up
        [:up]
      elsif direction == :down
        [:down]
      end
    end
  end

  def valid_pos?(pos)
    return false if pos.any? { |p| p < 0 }
    return false if pos.any? { |p| p >= @input.length }
    true
  end
end
