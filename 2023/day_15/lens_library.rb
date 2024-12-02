require_relative "../../src/toolkit"

class LensLibrary

  def initialize(file_name = "input.txt")
    @input = File.read(file_name, chomp: true).strip.split(",")
  end

  def execute_one
    @input.map do |string|
      LensString.new(string).hash_value
    end.sum
  end

  def execute_two
    @hashmap = Hash.new { |h, k| h[k] = [] }
    @input.each do |step|
      label, num = step.split(/=|-/)
      num = num.to_i
      box = LensString.new(label).hash_value
      index = @hashmap[box].index { |tuple| tuple[0] == label }

      if index
        @hashmap[box].delete_at(index)
      end

      next if num == 0

      if index
        @hashmap[box].insert(index, [label, num])
      else
        @hashmap[box] << [label, num]
      end
    end

    score = 0

    @hashmap.each do |key, lenses|
      lenses.each_with_index do |lens, i|
        score += (key + 1) * (i+1) * lens[1]
      end
    end

    score
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
