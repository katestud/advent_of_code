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
      left * right
    when "+"
      left + right
    when "||"
      "#{left}#{right}".to_i
    end
  end

  def perform(operators)
    total = 0
    @input.each do |line|
      expected, *values = line.split.map(&:to_i)
      operators.repeated_permutation(values.length - 1).each do |perm|
        acc, *rest = values
        perm.each_with_index do |operator, index|
          break if acc > expected
          acc = evaluate_instructions [acc, operator, rest[index]]
        end
        if acc == expected
          total += expected
          break
        end
      end
    end
    total
  end

end
