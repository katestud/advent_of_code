require_relative "../../src/toolkit"

require "set"

class GearRatios

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
    @symbol_positions = extract_symbol_positions
    @number_positions = extract_number_positions
  end

  def execute_one
    positions = []
    @symbol_positions.map { |s| positions.push(*s[:positions]) }
    @number_positions.select do |obj|
      obj[:positions].any? do |pos|
        positions.include?(pos)
      end
    end.map { |obj| obj[:number] }.sum
  end

  def execute_two
    nums = []
    @symbol_positions.each do |sym|
      next unless sym[:symbol] == "*"
      positions = sym[:positions]
      touching = @number_positions.select do |obj|
        obj[:positions].any? do |pos|
          positions.include?(pos)
        end
      end
      if touching.count == 2
        nums << touching.map { |n| n[:number].to_i }.reduce(:*)
      end
    end
    nums.sum
  end

  private

  def extract_symbol_positions(symbol = nil)
    symbol_positions = Set.new
    @input.each_with_index do |line, x|
      line.each_char.with_index do |char, y|
        if symbol
          next unless char == symbol
        else
          next if char == "."
          next if char =~ /\d/
        end
        symbol_positions << {
          symbol: char,
          positions: adjacent_positions([x,y])
        }
      end
    end
    symbol_positions
  end

  def extract_number_positions
    numbers = Set.new
    @input.each_with_index do |line, row_index|
      line.enum_for(:scan, /\d+/).each do |number_match|
        start_index = Regexp.last_match.begin(0)
        positions = number_match.length.times.map do |i|
          [row_index, start_index + i]
        end
        numbers << {
          number: number_match.to_i,
          positions: positions
        }
      end
    end
    numbers
  end
end
