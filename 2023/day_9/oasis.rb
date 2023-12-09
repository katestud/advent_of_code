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
    @input.map do |line|
      process([line], true)
    end.sum
  end

  private

  def process(list, part2 = false)
    diffs = find_diffs(list.last)
    list << diffs
    if diffs.all?(&:zero?)
      if part2
        traverse_list_part_2(list)
      else
        traverse_list(list)
      end
    else
      process(list, part2)
    end
  end

  def traverse_list(list)
    while list.size > 1
      last = list.pop
      list.last << list.last.last + last.last
    end
    list.last.last
  end

  def traverse_list_part_2(list)
    while list.size > 1
      last = list.pop
      list.last.unshift(list.last.first - last.first)
    end
    list.last.first
  end

  def find_diffs(list)
    list.each_cons(2).map do |i, j|
      j-i
    end
  end
end
