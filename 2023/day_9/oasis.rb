require_relative "../../src/toolkit"

class Oasis

  def initialize(file_name = "input.txt")
    @input = read_lines_with_separator(file_name, " ").map {|l| l.map(&:to_i)}
  end

  def execute_one
    @input.map do |line|
      process([line])
    end.sum
  end

  def execute_two
    @input.length
  end

  private

  #[first, second, third]
  # until third is all zeros
  # then pop off third
  # then add one more to second which is third.last plus second.last
  # then add one more to first which is second.last plus first.last

  def process(list)
    diffs = find_diffs(list.last)
    list << diffs
    if diffs.all?(&:zero?)
      traverse_list(list)
    else
      process(list)
    end
  end

  def traverse_list(list)
    while list.size > 1
      last = list.pop
      list.last << list.last.last + last.last
    end
    list.last.last
  end

  def find_diffs(list)
    list.each_cons(2).map do |i, j|
      j-i
    end
  end
end
