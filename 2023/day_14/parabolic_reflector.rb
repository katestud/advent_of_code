require_relative "../../src/toolkit"

class ParabolicReflector

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map(&:each_char).map(&:to_a)
  end

  def execute_one
    transposed = @input.transpose
    rolled = transposed.map do |column|
      length = column.size
      chunks = column.join.split("#")
      new_string = chunks.map do |chunk|
         chunk.each_char.sort.reverse.join
      end.join("#")
      if length > new_string.size
        new_string += "#" * (length-new_string.size)
      end
      new_string.each_char.to_a
    end
    length = rolled.length
    rolled.transpose.map.with_index do |row, index|
      val = row.count { |r| r == "O"} * (length - index)
    end.sum
  end

  def execute_two
    @input.length
  end
end
