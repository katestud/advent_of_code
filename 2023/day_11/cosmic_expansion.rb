require_relative "../../src/toolkit"

class CosmicExpansion

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
    @expanded_galaxies = find_starting_indexes
  end

  def execute_one
    sums = 0

    @expanded_galaxies.each_with_index do |pos, index|
      @expanded_galaxies[index+1..-1].each do |next_pos|
        dist = (0..pos.size-1).reduce(0) do |sum, i|
          sum + (pos[i] - next_pos[i]).abs
        end
        sums += dist
      end
    end
    sums
  end

  def execute_two
    @input.length
  end

  private

  def find_starting_indexes
    galaxies = []
    seen_rows = Set.new
    seen_columns = Set.new
    @input.each_with_index do |row, row_index|
      row.each_char.with_index do |column, column_index|
        next unless column == "#"
        galaxies << [row_index, column_index]
        seen_rows.add(row_index)
        seen_columns.add(column_index)
      end
    end
    empty_rows = 0.upto(@input.size - 1).to_a - seen_rows.to_a
    empty_columns = 0.upto(@input.size - 1).to_a - seen_columns.to_a

    galaxies.map do |(row_index, column_index)|
      new_row = row_index + empty_rows.count {|r| r < row_index}
      new_column = column_index + empty_columns.count {|r| r < column_index}
      [new_row, new_column]
    end
  end
end
