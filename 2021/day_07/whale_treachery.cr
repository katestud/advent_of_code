require "../../src/toolkit"

class WhaleTreachery
  @crab_positions : Array(Int32)
  def initialize(input_file = "input.txt")
    @crab_positions = read_line_of_integers(input_file)
  end

  def execute(part)
    constant_fuel = part == 1
    min, max = @crab_positions.minmax
    results = (min..max).map do |i|
      [i, diff(i, constant_fuel)]
    end
    results.min_by { |(pos, fuel)| fuel.as(Int32 | Float64) }.last
  end

  def diff(proposed, constant)
    if constant
      @crab_positions.map { |starting| (proposed - starting).abs }.sum
    else
      @crab_positions.map do |starting|
        target = (proposed - starting).abs
        target*(target+1)/2
      end.sum
    end
  end

end
