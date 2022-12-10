class CathodeRayTube

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @register = 1
    @registers = [0, 1]
    @cycles = [20, 60, 100, 140, 180, 220]
  end

  # Find the signal strength during the 20th, 60th, 100th, 140th, 180th, and 220th cycles. What is the sum of these six signal strengths?

  def execute_one
    read_file.each do |instruction|
      behavior, amount = instruction.split
      @registers << @register
      case behavior
      when "addx"
        @register = @register + amount.to_i
        @registers << @register
      when "noop"
        #noop
      end
    end
    @cycles.map do |cycle|
      @registers[cycle] * cycle
    end.sum
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

end
