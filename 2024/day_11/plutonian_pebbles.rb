require_relative "../../src/toolkit"

class PlutonianPebbles

  def initialize(file_name = "input.txt")
    @input = File.read(file_name).chomp.split.map(&:to_i)
  end

  # If the stone is engraved with the number 0, it is replaced by a stone engraved with the number 1.
  # If the stone is engraved with a number that has an even number of digits, it is replaced by two stones. The left half of the digits are engraved on the new left stone, and the right half of the digits are engraved on the new right stone. (The new numbers don't keep extra leading zeroes: 1000 would become stones 10 and 0.)
  # If none of the other rules apply, the stone is replaced by a new stone; the old stone's number multiplied by 2024 is engraved on the new stone.

  def execute_one
    execute(25)
  end

  def execute_two
    @input.length
  end

  private

  def execute(times)
    input = @input
    times.times do
      new_input = []
      input.each do |i|
        if i == 0
          new_input << 1
        elsif i.digits.size % 2 == 0
          half = i.digits.size / 2
          new_input << i.to_s[0, half].to_i
          new_input << i.to_s[half, half].to_i
        else
          new_input << i * 2024
        end
      end
      input = new_input
    end
    input.length
  end
end
