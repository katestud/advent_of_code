class TreetopTreeHouse

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @grid = read_file.map { |l| l.chars.map(&:to_i) }
  end

  def execute_one
    visible_count = 0
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        visible_count += 1 if visible?(row_index, cell_index)
      end
    end
    visible_count
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def visible?(row_index, cell_index)
    return true if perimeter?(row_index, cell_index)
    return true if visible_to_the_left?(row_index, cell_index)
    return true if visible_to_the_right?(row_index, cell_index)
    return true if visible_above?(row_index, cell_index)
    return true if visible_below?(row_index, cell_index)
    false
  end

  def perimeter?(row_index, cell_index)
    return true if row_index == 0
    return true if cell_index == 0
    return true if row_index == @grid.length - 1
    return true if cell_index == @grid[0].length - 1
  end

  def visible_to_the_left?(row_index, cell_index)
    row = @grid[row_index]
    row[0..cell_index-1].all? { |c| c < @grid[row_index][cell_index] }
  end

  def visible_to_the_right?(row_index, cell_index)
    row = @grid[row_index]
    row[cell_index+1..-1].all? { |c| c < @grid[row_index][cell_index] }
  end

  def visible_above?(row_index, cell_index)
    @grid[0..row_index-1].all? { |r| r[cell_index] < @grid[row_index][cell_index] }
  end

  def visible_below?(row_index, cell_index)
    @grid[row_index+1..-1].all? { |r| r[cell_index] < @grid[row_index][cell_index] }
  end

end
