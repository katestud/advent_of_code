require_relative "../../src/toolkit"

require "set"

class GearRatios

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
    extract_number_positions
  end

  def execute_one
    extract_symbol_positions
    positions = []
    @symbol_positions.map { |s| positions.push(*s[:positions]) }
    @numbers.select do |obj|
      obj[:positions].any? do |pos|
        positions.include?(pos)
      end
    end.map { |obj| obj[:number] }.sum
  end

  def execute_two
    extract_symbol_positions("*")
    nums = []
    @symbol_positions.each do |sym|
      positions = sym[:positions]
      touching = @numbers.select do |obj|
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
    @symbol_positions = Set.new
    @input.each_with_index do |line, x|
      line.each_char.with_index do |char, y|
        if symbol
          next unless char == symbol
        else
          next if char == "."
          next if char =~ /\d/
        end
        @symbol_positions << {
          symbol: char,
          positions: [
            [x, y],
            [x-1, y],
            [x-1, y-1],
            [x-1, y+1],
            [x+1, y],
            [x+1, y-1],
            [x+1, y+1],
            [x, y-1],
            [x, y+1]
          ]
        }
      end
    end
    # @touching = []
    # @symbol_positions.each do |x, y|
    #   @touching.push(
    #     [x, y],
    #     [x-1, y],
    #     [x-1, y-1],
    #     [x-1, y+1],
    #     [x+1, y],
    #     [x+1, y-1],
    #     [x+1, y+1],
    #     [x, y-1],
    #     [x, y+1]
    #   )
    # end
  end

  def extract_number_positions
    @numbers = Set.new
    @input.each_with_index do |line, row_index|
      line.enum_for(:scan, /\d+/).each do |number_match|
        start_index = Regexp.last_match.begin(0)
        positions = number_match.length.times.map do |i|
          [row_index, start_index + i]
        end
        @numbers << {
          number: number_match.to_i,
          positions: positions
        }
      end
    end
  end
end
