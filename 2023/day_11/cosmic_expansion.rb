require_relative "../../src/toolkit"

class CosmicExpansion

  def initialize(file_name = "input.txt", multiplier = 2)
    @input = File.readlines(file_name, chomp: true)
    @expanded_galaxies = expand_galaxies(multiplier)
  end

  def execute
    pairs(@expanded_galaxies).each.reduce(0) do |sum, (pos, next_pos)|
      sum + manhattan_distance(pos, next_pos)
    end
  end

  private

  def expand_galaxies(multiplier)
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
      new_row = row_index + (empty_rows.count {|r| r < row_index} * (multiplier - 1))
      new_column = column_index + (empty_columns.count {|r| r < column_index} * (multiplier - 1))
      [new_row, new_column]
    end
  end
end
