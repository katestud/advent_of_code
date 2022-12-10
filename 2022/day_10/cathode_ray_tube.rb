class CathodeRayTube

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @register = 1
    @registers = [@register]
  end

  # Find the signal strength during the 20th, 60th, 100th, 140th, 180th, and 220th cycles. What is the sum of these six signal strengths?

  def execute_one
    build_registers
    [20, 60, 100, 140, 180, 220].map do |cycle|
      @registers[cycle - 1] * cycle
    end.sum
  end

  # Start cycle   1: begin executing addx 15
  # During cycle  1: CRT draws pixel in position 0
  # Current CRT row: #

  # During cycle  2: CRT draws pixel in position 1
  # Current CRT row: ##
  # End of cycle  2: finish executing addx 15 (Register X is now 16)
  # Sprite position: ...............###......................

  # Start cycle   3: begin executing addx -11
  # During cycle  3: CRT draws pixel in position 2
  # Current CRT row: ##.

  def execute_two
    build_registers
    @registers.map.with_index do |register, index|
      position = index % 40
      if (position-1..position+1).cover?(register)
        "#"
      else
        "."
      end
    end.each_slice(40) { |row| puts row.join }
    nil
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def build_registers
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
  end

end
