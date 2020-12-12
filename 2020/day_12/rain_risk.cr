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

end
