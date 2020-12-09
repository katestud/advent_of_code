class Encoder

  attr_reader :preamble_length, :input

  def initialize(input_file, preamble_length: 25)
    @preamble_length = preamble_length
    @input = File.readlines(input_file).map(&:to_i)
  end

  def first_invalid
    return @first_invalid if @first_invalid

    @first_invalid = input.detect.with_index do |num, index|
      next false if index < @preamble_length

      !valid?(num, index)
    end
  end

  def find_contiguous_sum
    set = find_contiguous_set.max + find_contiguous_set.min
  end

  def find_contiguous_set
    invalid = first_invalid
    input.each_with_index do |num, index|
      sum = 0
      i = index
      while sum < invalid
        sum += num
        i += 1
        num = input[i]
      end
      if sum == invalid
        return input[index..i-1]
      end
    end
  end

  private

  def valid?(num, index)
    preceding = input[index - preamble_length, preamble_length]

    preceding.combination(2).any? { |c| c.sum == num }
  end

end

puts "Test Input:"
encoder = Encoder.new("test_input.txt", preamble_length: 5)
invalid = encoder.first_invalid
contiguous_sum = encoder.find_contiguous_sum
puts "First Invalid: #{invalid}"
puts "Contiguous sum: #{contiguous_sum}"
puts "================================="
puts "Actual Input:"
encoder = Encoder.new("input.txt", preamble_length: 25)
puts "First Invalid: #{encoder.first_invalid}"
puts "Contiguous sum: #{encoder.find_contiguous_sum}"
