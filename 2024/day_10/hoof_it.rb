require_relative "../../src/toolkit"

class HoofIt

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map { |l| l.each_char.to_a.map(&:to_i)}
    @grid_size = @input.length
    @found_paths = Hash.new { |h, k| h[k] = Set.new }
  end

  def execute_one
    @input.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next unless column == 0
        current_pos = [row_index, column_index]
        next_paths = potential_paths(current_pos)
        traverse_paths(current_pos, next_paths)
      end
    end
    @found_paths.values.map(&:size).sum
  end

  def execute_two
    @input.length
  end

  private

  def directions
    [[0,1], [1,0], [0, -1], [-1, 0]]
  end

  def within_bounds?(pos)
    pos.all? { |i| i >= 0 && i < @grid_size }
  end

  def potential_paths(pos)
    directions.select.map do |dir|
      next_pos = [pos[0]+dir[0], pos[1]+dir[1]]
      next unless within_bounds?(pos)
      next unless @input.dig(*next_pos) == @input.dig(*pos) + 1
      next_pos
    end.compact
  end

  def traverse_paths(start_pos, next_paths)
    next_paths.each do |pos|
      potential_next = potential_paths(pos)
      break if potential_next.empty?
      end_paths = potential_next.select { |p| @input.dig(*p) == 9 }
      if end_paths.any?
        end_paths.each do |path|
          @found_paths[start_pos].add(path)
        end
      end
      traverse_paths(start_pos, potential_next)
    end
  end
end
