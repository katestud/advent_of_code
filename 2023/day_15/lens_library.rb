require_relative "../../src/toolkit"

class LensLibrary

  def initialize(file_name = "input.txt")
    @input = File.read(file_name, chomp: true).strip
  end

  def execute_one
    @input.split(",").map do |string|
      LensString.new(string).hash_value
    end.sum
  end

  def execute_two
    @input.length
  end
end

class LensString
  def initialize(string)
    @string = string
  end

  def hash_value
    val = @string.each_byte.reduce(0) do |sum, char|
      sum += char
      sum = sum * 17
      sum = sum % 256
    end
    val
  end
end
