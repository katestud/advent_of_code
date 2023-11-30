require_relative "../../src/toolkit"

class CalorieCounter

  def initialize(file_name = "input.txt")
    @batches = read_file_into_batches(file_name)
  end

  def execute_one
    @batches.map do |batch|
      batch.map(&:to_i).sum
    end.max
  end

  def execute_two
    @batches.map do |batch|
      batch.map(&:to_i).sum
    end.sort.reverse.take(3).sum
  end
end
