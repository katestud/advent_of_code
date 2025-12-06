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
    paper_count = @input.flatten.count { |v| v == "@" }
    new_grid = @input.map(&:dup)
    changed = true

    while changed do
      changed = false
      grid = new_grid
      new_grid = grid.map(&:dup)

      grid.each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          next unless column == "@"
          neighboring_papers =
            adjacent_positions([row_index, column_index], omit_self: true)
              .map { |y, x| grid.dig(y, x) }
              .count { |v| v == "@" }
          if neighboring_papers < 4
            new_grid[row_index][column_index] = "X"
            changed = true
          end
        end
      end
    end
    new_grid.flatten.count { |v| v == "X" }
  end
end
