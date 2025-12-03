require_relative "../../src/toolkit"

class Lobby

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map {|l| l.chars.map(&:to_i) }
  end

  def execute_one
    @input.sum do |row|
      find_joltage(row, 2)
    end
  end

  def execute_two
    @input.sum do |row|
      find_joltage(row, 12)
    end
  end

  def find_joltage(row, length)
    digits = []
    start_index = 0
    (-length).upto(-1).each do |i|
      slice = row[start_index..i]
      next_digit = slice.max
      digits << next_digit
      start_index = slice.index(next_digit) + start_index + 1
    end
    digits.join.to_i
  end
end
