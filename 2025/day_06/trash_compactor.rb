require_relative "../../src/toolkit"

class TrashCompactor

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    read_lines_with_separator(@file_name, " ").transpose.sum do |problem|
      operator = problem.pop
      eval(problem.join(operator))
    end
  end

  def execute_two
    rows = File.readlines(@file_name)
    operators = rows.pop.split(" ")
    iterations = rows.max_by(&:length).length
    current = []
    nums = []
    iterations.times do |i|
      val = rows.map { |str| str[i] }.join
      if val.strip.empty?
        nums << current
        current = []
      else
        current << val
      end
    end
    total = 0
    nums.each_with_index do |row, index|
      operator = operators[index]
      total += eval(row.join(operator))
    end
    total
  end
end
