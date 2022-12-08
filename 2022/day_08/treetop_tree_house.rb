class TreetopTreeHouse

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @grid = read_file.map { |l| l.chars.map(&:to_i) }
    @highest_scenic_score = 0
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
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        next if perimeter?(row_index, cell_index)
        score = score_for_cell(row_index, cell_index)
        @highest_scenic_score = score if score > @highest_scenic_score
      end
    end
    @highest_scenic_score
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def score_for_cell(row_index, cell_index)
    cell_value = @grid[row_index][cell_index]
    score_right = score_to_the_right(row_index, cell_index, cell_value)
    score_left = score_to_the_left(row_index, cell_index, cell_value)
    score_above = score_above(row_index, cell_index, cell_value)
    score_below = score_below(row_index, cell_index, cell_value)
    score_right * score_left * score_above * score_below
  end

  def score_to_the_right(row_index, cell_index, cell_value)
    count_score @grid[row_index][cell_index+1..-1], cell_value
  end

  def score_to_the_left(row_index, cell_index, cell_value)
    count_score @grid[row_index][0..cell_index-1].reverse, cell_value
  end

  def score_above(row_index, cell_index, cell_value)
    count_score @grid[0..row_index-1].map { |r| r[cell_index] }.reverse, cell_value
  end

  def score_below(row_index, cell_index, cell_value)
    count_score @grid[row_index+1..-1].map { |r| r[cell_index] }, cell_value
  end

  def count_score(arr, cell_value)
    count = 0
    arr.each do |cell|
      count += 1
      break if cell >= cell_value
    end
    count
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
