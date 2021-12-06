class Lanternfish
  @fish : Array(Int32)
  def initialize(input_file = "input.txt")
    @fish = File.read_lines(input_file).first.split(",").map {|i| i.to_i}
  end

  def execute_one
    80.times do
      zeros = 0
      @fish = @fish.map do |i|
        if i == 0
          zeros += 1
          6
        else
          i - 1
        end
      end
      @fish += Array.new(zeros, 8)
    end
    @fish.size
  end

  def execute_two
    return 0
  end
end
