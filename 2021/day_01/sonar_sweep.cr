require "../../src/toolkit"

class SonarSweep
  @input : Array(Int32)
  def initialize(input_file = "input.txt")
    @input = read_lines_of_integers(input_file)
  end

  def execute_one
    find_increases(@input)
  end

  def execute_two
    sums = @input.each_cons(3).map { |slice| slice.sum }
    find_increases(sums)
  end

  def find_increases(input)
    increases = 0
    input.each_cons_pair do |depth, next_depth|
      increases += 1 if next_depth > depth
    end
    increases
  end
end
