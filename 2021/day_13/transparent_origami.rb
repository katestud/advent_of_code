class TransparentOrigami

  def initialize(file_name = "input.txt")
    input = File.read(file_name, chomp: true)
    positions, @instructions = input.split("\n\n").map { |str| str.split("\n") }
    positions = positions.map { |line| line.split(",").map(&:to_i) }.map(&:reverse)
    height = positions.max_by(&:first).first + 1
    width = positions.max_by(&:last).last + 1
    @grid = Array.new(height) { Array.new(width) { "." } }
    positions.each do |(y,x)|
      @grid[y][x] = "#"
    end
  end

  def execute_one
    execute_instructions(1)
    @grid.flatten.count { |val| val == "#" }
  end

  def execute_two
    execute_instructions(@instructions.length)
    puts "="*@grid.first.length
    @grid.each do |row|
      puts row.join("")
    end
    puts "="*@grid.first.length
    nil
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
        next if val == "." && bottom[(x-i-1)]
        bottom[(x-i-1)] = "#"
      end
      bottom
    end
    @grid = new_grid
  end

  def vertical_fold(y)
    new_grid = @grid.slice(0, y)
    @grid.slice(y+1, @grid.length - 1).each_with_index do |row, i|
      row.each_with_index do |val, j|
        next if val == "." && new_grid[(y-i-1)][j]
        new_grid[(y-i-1)][j] = "#"
      end
    end
    @grid = new_grid
  end

end
