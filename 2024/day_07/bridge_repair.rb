require_relative "../../src/toolkit"

class BridgeRepair

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    perform(['*', '+'])
  end

  def execute_two
    perform(['*', '+', '||'])
  end

  private

  def evaluate_instructions(instructions)
    left, operator, right = instructions
    case operator
    when "*"
      left.to_i * right.to_i
    when "+"
      left.to_i + right.to_i
    when "||"
      "#{left}#{right}".to_i
    end
  end

  def perform(operator_options)
    sum_found_values = 0
    @input.each do |line|
      first, *values = line.split
      values.map!(&:to_i)
      expected = first.to_i
      operator_options.repeated_permutation(values.length - 1).each do |perm|
        acc, *rest = values
        perm.each_with_index do |operator, index|
          break if acc > expected
          acc = evaluate_instructions [acc, operator, rest[index]]
        end
        if acc == expected
          sum_found_values += expected
          break
        end
      end
    end
    sum_found_values
  end

end
