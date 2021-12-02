class Dive
  @input : Array(String)
  def initialize(input_file = "input.txt")
    @input = File.read_lines(input_file)
    @horizontal = 0
    @depth = 0
    @aim = 0
  end

  def execute_one
    @input.each do |line|
      dir, dist = line.split
      case dir
      when "forward"
        @horizontal += dist.to_i
      when "down"
        @depth += dist.to_i
      when "up"
        @depth -= dist.to_i
      end
    end
    @depth*@horizontal
  end

  def execute_two
    @input.each do |line|
      dir, dist = line.split
      case dir
      when "forward"
        @horizontal += dist.to_i
        @depth += @aim * dist.to_i
      when "down"
        @aim += dist.to_i
      when "up"
        @aim -= dist.to_i
      end
    end
    @depth*@horizontal
  end
end
