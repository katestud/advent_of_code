require_relative "../../src/toolkit"

class MovieTheater

  def initialize(file_name = "input.txt")
    @input = read_lines_with_separator(file_name).map { |l| l.map(&:to_i) }
  end

  def execute_one
    all_pairs = @input.combination(2)
    all_areas = all_pairs.map do |one, two|
      ((one[0] - two[0]).abs + 1) * ((one[1] - two[1]).abs + 1)
    end
    all_areas.max
  end

  def execute_two
    @input.length
  end
end
