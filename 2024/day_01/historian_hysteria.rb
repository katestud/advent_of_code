require_relative "../../src/toolkit"

class HistorianHysteria

  def initialize(file_name = "input.txt")
    @right = []
    @left = []
    File.readlines(file_name, chomp: true).each do |line|
      l, r = line.split(" ")
      @right << r.to_i
      @left << l.to_i
    end
  end

  def execute_one
    @left.sort.zip(@right.sort).map do |l,r|
      (l - r).abs
    end.sum
  end

  def execute_two
    right_counts = @right.each_with_object(Hash.new(0)) do |location, hash|
      hash[location] += 1
    end
    @left.map do |l|
      right_counts[l] * l
    end.sum
  end
end
