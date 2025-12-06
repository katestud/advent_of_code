require_relative "../../src/toolkit"

class TrashCompactor

  def initialize(file_name = "input.txt")
    @input = read_lines_with_separator(file_name, " ").transpose
  end

  def execute_one
    @input.sum do |problem|
      operator = problem.pop
      eval(problem.join(operator))
    end
  end

  def execute_two
    @input.length
  end
end
