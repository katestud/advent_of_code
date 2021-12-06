require "../../src/toolkit"

class Lanternfish
  @fish : Array(Int32)
  @fish_counts : Hash(Int32, Int128)
  def initialize(input_file = "input.txt")
    @fish = read_line_of_integers(input_file)
    @fish_counts = Hash(Int32, Int128).new(0)
    (0..8).each do |i|
      @fish_counts[i] = @fish.count(i).to_i128
    end
  end

  def execute_one
    execute(80)
  end

  def execute_two
    execute(256)
  end

  def execute(times)
    times.times do
      new_counts = Hash(Int32, Int128).new(0)
      (1..8).to_a.reverse.each do |i|
        new_counts[i-1] = @fish_counts[i]
      end
      new_counts[8] = @fish_counts[0]
      new_counts[6] = new_counts[6] + new_counts[8]
      @fish_counts = new_counts
    end
    @fish_counts.values.sum
  end
end
