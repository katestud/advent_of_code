require_relative "../../src/toolkit"

class BridgeRepair

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    sum_found_values = 0
    @input.each do |line|
      first, *values = line.split
      expected = first.to_i
      ['+', '*'].repeated_permutation(values.length - 1).each do |perm|
        acc, *rest = values
        perm.each_with_index do |operator, index|
          str = "#{acc} #{operator} #{rest[index]}"
          acc = eval(str)
        end
        if acc == expected
          sum_found_values += expected
          break
        end
      end
    end
    sum_found_values
  end

  def execute_two
    @input.length
  end
end
