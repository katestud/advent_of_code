require_relative "../../src/toolkit"

class RedNosedReports

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map do |l|
      l.split(" ").map(&:to_i)
    end
  end

  def execute_one
    @input.select do |levels|
      dir = nil
      levels.each_cons(2) do |i, j|
        diff = i - j
        break if diff.zero?
        if diff < 0
          new_dir = :dec
        else
          new_dir = :inc
        end
        break if dir && dir != new_dir
        dir = new_dir
        break if diff.abs > 3
        true
      end
    end.count
  end

  def execute_two
    @input.length
  end
end
