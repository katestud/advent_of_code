class SonarSweep
	@input : Array(Int32)
	def initialize(input_file = "input.txt")
		@input = File.read_lines(input_file).map { |l| l.to_i }
	end

  def execute_one
    find_increases(@input)
  end

  def execute_two
    sums = @input.each_cons(3).map { |slice| slice.sum }
    find_increases(sums)
  end

  def find_increases(input)
    increases = 0
    input.each_cons_pair do |depth, next_depth|
      increases += 1 if next_depth > depth
    end
    increases
  end
end
