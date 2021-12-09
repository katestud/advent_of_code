require 'set'
class SmokeBasin

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map {|line| line.split("").map(&:to_i)}
  end

  def execute_one
    low_point_indexes.map do |index|
      @input[index[0]][index[1]]
    end.sum + low_point_indexes.length
  end

  def execute_two
    low_point_indexes.map do |point|
      basin_positions = Set.new
      recursive_add_items([point], basin_positions)
      basin_positions.count
    end.sort.reverse[0..2].reduce(&:*)
  end

  private

  def low_point_indexes
    low_point_indexes = []
    @input.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        if relative_positions([row_index, cell_index]).map {|pos| @input.dig(*pos)}.compact.all? { |point| point > cell }
          low_point_indexes << [row_index, cell_index]
        end
      end
    end
    low_point_indexes
  end

  def recursive_add_items(points, set)
    remaining = []
    points.map do |point|
      surrounding_high_points(point, set)
    end.compact.select do |(found, list)|
      found
    end.each { |(found, list)| remaining += list }
    return [] if remaining.empty?
    recursive_add_items(remaining, set).flatten
  end

  def surrounding_high_points(point, set)
    set.add(point)
    row_index, cell_index = point
    surrounding = relative_positions(point).select do |pos|
      next unless [pos[0], pos[1]].all? { |i| i >= 0 }
      next if set.include?(pos)
      val = @input.dig(*pos).to_i
      val > @input.dig(row_index, cell_index) && val != 9
    end
    new_items_found = surrounding.any? do |pos|
      set.add?(pos)
    end
    [new_items_found, surrounding]
  end

  def relative_positions(point)
    row_index, cell_index = point
    [[(row_index - 1), cell_index], [(row_index + 1), cell_index], [row_index, (cell_index - 1)], [row_index, (cell_index + 1)]]
  end

end
