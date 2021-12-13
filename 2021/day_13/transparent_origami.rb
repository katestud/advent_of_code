class TransparentOrigami

  def initialize(file_name = "input.txt")
    input = File.read(file_name, chomp: true)
    positions, instructions = input.split("\n\n")
    @positions = positions.split("\n").map { |line| line.split(",").map(&:to_i) }.map(&:reverse)
    @instructions = instructions.split("\n")
    height = @positions.max_by(&:first).first + 1
    width = @positions.max_by(&:last).last + 1
    puts height
    puts width
    @grid = Array.new(height) { Array.new(width) { 0 } }
    @positions.each do |(y,x)|
      @grid[y][x] = 1
    end
  end

  def execute_one
    execute_instructions(1)
    @grid.flatten.count { |val| val > 0 }
  end

  def execute_two
    0
  end

  private

  def execute_instructions(limit = nil)
    @instructions.take(limit).each do |instruction|
      direction, val = instruction.split("=")
      if direction.start_with?("fold along y")
        vertical_fold(val.to_i)
      else
        horizontal_fold(val.to_i)
      end
    end
  end

  def horizontal_fold(x)
    new_grid = @grid.map do |row|
      bottom = row.slice(0, x)
      top = row.slice(x+1, row.length - 1).each_with_index do |val, i|
        bottom[(x-i-1)] += val
      end
      bottom
    end
    @grid = new_grid
  end

  def vertical_fold(y)
    new_grid = @grid.slice(0, y)
    @grid.slice(y+1, @grid.length - 1).each_with_index do |row, i|
      row.each_with_index do |val, j|
        new_grid[(y-i-1)][j] += val
      end
    end
    @grid = new_grid
  end

end
