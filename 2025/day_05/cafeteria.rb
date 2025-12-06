require_relative "../../src/toolkit"

class Cafeteria

  def initialize(file_name = "input.txt")
    ranges, ids = read_file_into_batches(file_name)
    @ranges = ranges.map do |range_string|
      f, l = range_string.split("-").map(&:to_i)
      (f..l)
    end
    @available_ids = ids.map(&:to_i).to_set
  end

  def execute_one
    @available_ids.count do |i|
      @ranges.any? { |range| range.member?(i) }
    end
  end

  def execute_two
    0
  end
end
