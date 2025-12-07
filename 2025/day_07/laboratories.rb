require_relative "../../src/toolkit"

class Laboratories

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map(&:chars)
  end

  def execute_one
    first_row = @input.shift
    new_beam_positions = [first_row.index("S")]
    splits = 0

    @input.each_with_index do |row, row_index|
      beam_positions = new_beam_positions
      new_beam_positions = []
      row.each_with_index do |column, column_index|
        next unless beam_positions.include?(column_index)
        if column == "."
          new_beam_positions << column_index
        elsif column == "^"
          splits += 1
          new_beam_positions << (column_index - 1)
          new_beam_positions << (column_index + 1)
        end
      end
    end
    splits
  end

  def execute_two
    @input.length
  end
end
