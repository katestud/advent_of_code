# Action N means to move north by the given value.
# Action S means to move south by the given value.
# Action E means to move east by the given value.
# Action W means to move west by the given value.
# Action L means to turn left the given number of degrees.
# Action R means to turn right the given number of degrees.
# Action F means to move forward by the given value in the direction the ship is currently facing.

class RainRisk
  @input : Array(String)
  @directions : Array(Char) = ['E', 'S', 'W', 'N', 'E', 'S', 'W', 'N']

	def initialize(input_file = "input.txt")
    @input = File.read_lines(input_file)
    @direction = 'E'
    @position = [0, 0]
    @fourway_position = [0, 0, 0, 0]
    @waypoint = [1, 10, 0, 0]
  end

  def manhattan_distance
    @input.each do |instruction|
      behavior = instruction[0]
      count = instruction[1..-1].to_i
      if behavior.in_set?("NSEWF")
        move(behavior, count)
      else
        rotate(behavior, count)
      end
    end
    @position.map { |i| i.abs }.sum
  end

  def move(direction, amount)
    case direction
    when 'F'
      move(@direction, amount)
    when 'N'
      @position[1] += amount
    when 'S'
      @position[1] -= amount
    when 'E'
      @position[0] += amount
    when 'W'
      @position[0] -= amount
    end
  end

  def rotate(direction, amount)
    steps = (amount / 90).to_i
    current_index = @directions.index(@direction) || 0
    case direction
    when 'R'
      @direction = @directions[current_index + steps]
    when 'L'
      @direction = @directions[current_index - steps]
    end
  end

  def manhattan_distance_waypoint
    @input.each do |instruction|
      behavior = instruction[0]
      count = instruction[1..-1].to_i
      if behavior.in_set?("NSEWF")
        move_waypoint(behavior, count)
      else
        rotate_waypoint(behavior, count)
      end
    end
    puts @waypoint
    (@fourway_position[0] - @fourway_position[2]).abs + (@fourway_position[1] - @fourway_position[3])
  end

  def move_waypoint(direction, amount)
    case direction
    when 'F'
      @fourway_position[0] += @waypoint[0] * amount
      @fourway_position[1] += @waypoint[1] * amount
      @fourway_position[2] += @waypoint[2] * amount
      @fourway_position[3] += @waypoint[3] * amount
    when 'N'
      @waypoint[0] += amount
    when 'S'
      @waypoint[2] += amount
    when 'E'
      @waypoint[1] += amount
    when 'W'
      @waypoint[3] += amount
    end
  end

  def rotate_waypoint(direction, amount)
    steps = (amount / 90).to_i
    current_index = @directions.index(@direction) || 0
    case direction
    when 'R'
      steps.times do
        val = @waypoint.pop
        @waypoint.unshift(val)
      end
    when 'L'
      steps.times do
        val = @waypoint.shift
        @waypoint << val
      end
    end
  end

end
