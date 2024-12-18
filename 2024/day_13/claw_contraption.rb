require_relative "../../src/toolkit"


# The cheapest way to win the prize is by pushing the A button 80 times and the B button 40 times. This would line up the claw along the X axis (because 80*94 + 40*22 = 8400) and along the Y axis (because 80*34 + 40*67 = 5400). Doing this would cost 80*3 tokens for the A presses and 40*1 for the B presses, a total of 280 tokens.

# For the second and fourth claw machines, there is no combination of A and B presses that will ever win a prize.

# For the third claw machine, the cheapest way to win the prize is by pushing the A button 38 times and the B button 86 times. Doing this would cost a total of 200 tokens.

# So, the most prizes you could possibly win is two; the minimum tokens you would have to spend to win all (two) prizes is 480.


class ClawContraption

  def initialize(file_name = "input.txt")
    @contraptions = read_file_into_batches(file_name)
  end

  def execute_one
    @contraptions.map do |c|
      a, b, pr = c
      a = Button.new(a)
      b = Button.new(b)
      pr = Prize.new(pr)
      find_min(a, b, pr)
    end.compact.sum
  end

  def execute_two
    @contraptions.length
  end

  private

  def find_min(a, b, prize)
    min = nil
    100.downto(0) do |i|
      rem = prize.x - (b.x * i)
      next if rem < 0
      if rem % a.x == 0
        j = rem / a.x
        if (j * a.y) + (i * b.y) == prize.y
          min = j * 3 + i
          break
        end
      end
    end
    min
  end
end

class Prize
  attr_reader :x, :y

  def initialize(row)
    match = row.match(/.+=(\d+).+=(\d+)/)
    @x = match[1].to_i
    @y = match[2].to_i
  end
end

class Button
  attr_reader :x, :y

  def initialize(row)
    match = row.match(/.+X\+(\d+).+Y\+(\d+)/)
    @x = match[1].to_i
    @y = match[2].to_i
  end

end
