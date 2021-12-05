class HydrothermalVenture

  @input : Array(Array(Int32))
  @grid : Array(Array(Int32))
  def initialize(input_file = "input.txt")
    @input = File.read_lines(input_file).map { |line| line.split(/\s\-\>\s|\,/).map {|i| i.to_i} }
    @grid = [Array.new(1000, 0)]
    999.times { @grid <<  Array.new(1000, 0) }
  end

  def execute_one
    execute
  end

  def execute_two
    execute(true)
  end

  def execute(diagonal = false)
    @input.each do |coords|
      x1, y1, x2, y2 = coords
      if horizontal_line?(x1, y1, x2, y2)
        start, ending = [x1, x2].sort
        (start..ending).each { |x| @grid[y1][x] += 1 }
      elsif vertical_line?(x1, y1, x2, y2)
        start, ending = [y1, y2].sort
        (start..ending).each { |y| @grid[y][x1] += 1 }
      elsif diagonal
        starty, endy = [y1, y2]
        startx, endx = [x1, x2]
        stop = false
        until stop
          @grid[starty][startx] += 1
          stop = starty == endy
          if x1 > x2
            startx -= 1
          else
            startx += 1
          end
          if y1 > y2
            starty -= 1
          else
            starty += 1
          end
        end
      end
    end
    @grid.flatten.count { |i| i > 1 }
  end

  private def horizontal_line?(x1, y1, x2, y2)
    y1 == y2
  end

  private def vertical_line?(x1, y1, x2, y2)
    x1 == x2
  end
end
