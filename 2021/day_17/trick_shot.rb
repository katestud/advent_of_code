class TrickShot

  def initialize(file_name = "input.txt")
    input = File.read(file_name, chomp: true).strip
    eval(input.sub("target area: ", "@").sub(", ", ";@"))
    @x_range = @x
    @y_range = @y
    @max_y = [0, [0,0]]
  end

  def execute_one
    execute
    @max_y[0]
  end

  def execute_two
    execute
  end

  private

  def execute
    (start_x..@x_range.end).map do |x|
      (@y_range.begin..500).count do |y|
        reaches_target?(x, y)
      end
    end.sum
  end

  def reaches_target?(x, y)
    success = false
    initial_velocity = [x, y]
    pos = [0, 0]
    max_y = 0
    loop do
      new_pos = [pos[0] + x, pos[1] + y]
      if @x_range.cover?(new_pos[0]) && @y_range.cover?(new_pos[1])
        success = true
        break
      elsif new_pos[0] > @x_range.end || new_pos[1] < @y_range.begin
        break
      end
      if new_pos[1] > max_y
        max_y = new_pos[1]
      end
      pos = new_pos
      y -= 1
      if x > 0
        x -= 1
      elsif x < 0
        x += 1
      end
    end
    if success && max_y > @max_y[0]
      @max_y = [max_y, initial_velocity]
    end
    success
  end

  def start_x
    start = @x_range.begin
    factorial = start.downto(1).inject(:+)
    while factorial > @x_range.begin
      start -= 1
      factorial = start.downto(1).inject(:+)
    end
    start
  end

end
