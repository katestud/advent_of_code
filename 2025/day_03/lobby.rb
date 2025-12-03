require_relative "../../src/toolkit"

class Lobby

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map {|l| l.chars.map(&:to_i) }
  end

  def execute_one
    @input.sum do |row|
      first_digit = row[0..-2].max
      start_index = row.index(first_digit)
      second_digit = row[start_index+1..-1].max
      [first_digit, second_digit].join.to_i
    end
  end

  def execute_two
    @input.length
  end
end
