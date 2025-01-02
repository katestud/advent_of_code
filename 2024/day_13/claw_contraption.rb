require_relative "../../src/toolkit"

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
    @contraptions.map do |c|
      a, b, pr = c
      a = Button.new(a)
      b = Button.new(b)
      pr = Prize.new(pr, 10000000000000)

      # Using linear algebra to find the solution
      determinant = (a.x * b.y) - (a.y * b.x)
      return nil if determinant == 0

      # Find the solution using Cramer's rule
      numerator_x = (pr.x * b.y - pr.y * b.x)
      numerator_y = (a.x * pr.y - a.y * pr.x)

      # Instead of checking division, let's try to find the smallest positive solution
      # that satisfies our equations: ax + by = pr
      x = numerator_x.abs / determinant.abs
      y = numerator_y.abs / determinant.abs

      # Verify the solution
      if (a.x * x + b.x * y == pr.x) && (a.y * x + b.y * y == pr.y)
        result = (x * 3 + y)
        result
      else
        nil
      end
    end.compact.sum
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
  attr_accessor :x, :y

  def initialize(row, increment = 0)
    match = row.match(/.+=(\d+).+=(\d+)/)
    @x = match[1].to_i + increment
    @y = match[2].to_i + increment
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
