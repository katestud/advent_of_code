require "../../src/toolkit"

class WhaleTreachery
  @crab_positions : Array(Int32)
  def initialize(input_file = "input.txt")
    @crab_positions = read_line_of_integers(input_file)
  end

  def execute_one
    min, max = @crab_positions.minmax
    results = (min..max).map do |i|
      diff = @crab_positions.map { |j| (i - j).abs }.sum
      [i, diff]
    end
    results.min_by { |(pos, fuel)| fuel.as(Int32) }.last
  end

  def execute_two
    min, max = @crab_positions.minmax
    results = (min..max).map do |i|
      diff = @crab_positions.map do |j|
        target = (i - j).abs
        (1..target).to_a.map_with_index(1) do |i, index|
          index
        end.sum
      end.sum
      [i, diff]
    end
    results.min_by { |(pos, fuel)| fuel.as(Int32) }.last
  end

end
