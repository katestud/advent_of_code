require_relative "../../src/toolkit"

class PrintingDepartment

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map(&:chars)
  end

  def execute_one
    count = 0
    @input.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next unless column == "@"
        neighboring_papers =
          adjacent_positions([row_index, column_index], omit_self: true)
            .map { |y, x| @input.dig(y, x) }
            .count { |v| v == "@" }
        count += 1 if neighboring_papers < 4
      end
    end
    count
  end

  def execute_two
    @input.length
  end
end
