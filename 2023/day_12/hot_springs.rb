require_relative "../../src/toolkit"

class HotSprings

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    @input.map do |line|
      count_arrangements(line)
    end.sum
  end

  def execute_two
    @input.length
  end

  def count_arrangements(line)
    springs, counts = line.split
    counts = counts.split(",").map(&:to_i)

    options = [springs]

    # Brute force iterate through all the characters and build up all
    # possible strings. We'll check if they're valid later.
    springs.each_char.with_index do |spring, index|
      next if [".", "#"].include?(spring)
      options = options.map do |s|
        broken = s.dup
        broken[index] = "#"

        fixed = s.dup
        fixed[index] = "."

        [broken, fixed]
      end.flatten
    end

    options.select do |start|
      start.split(".").delete_if { |s| s.empty? }.map(&:length) == counts
    end.count
  end
end
