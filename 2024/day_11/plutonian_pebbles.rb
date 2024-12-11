require_relative "../../src/toolkit"

class PlutonianPebbles

  def initialize(file_name = "input.txt")
    input = File.read(file_name).chomp.split.map(&:to_i)
    @value_counts = input.each_with_object(Hash.new(0)) do |num, hash|
      hash[num] += 1
    end
  end

  def execute_one
    execute(25)
  end

  def execute_two
    execute(75)
  end

  private

  def execute(times)
    input = @value_counts
    times.times do |t|
      new_input = Hash.new(0)
      input.each do |n, count|
        if n == 0
          new_input[1] += count
        elsif n.digits.size % 2 == 0
          half = n.digits.size / 2
          new_input[n.to_s[0, half].to_i] += count
          new_input[n.to_s[half, half].to_i] += count
        else
          new_input[n * 2024] += count
        end
      end
      input = new_input
    end
    input.values.sum
  end
end
