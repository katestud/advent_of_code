require_relative "../../src/toolkit"

class HistorianHysteria

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)

  end

  def execute_one
    right = []
    left = []
    @input.each do |line|
      l, r = line.split(" ")
      right << r.to_i
      left << l.to_i
    end
    left.sort.zip(right.sort).map do |l,r|
      (l - r).abs
    end.sum
  end

  def execute_two
    @input.length
  end
end
