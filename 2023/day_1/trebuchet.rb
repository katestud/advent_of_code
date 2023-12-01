require_relative "../../src/toolkit"

class Trebuchet

  VALID_DIGITS = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    @input.map do |line|
      digits = line.scan(/\d/)
      val = digits[0] + digits[-1]
      val.to_i
    end.sum
  end

  def execute_two
    @input.map do |line|
      # Positive lookahead with capturing to capture scenarios like "oneeight"
      options = "(?=(" + VALID_DIGITS.keys.join("|") + "|\\d" + "))"
      regex = Regexp.new(options)
      digits = line.downcase.scan(regex).flatten
      val = get_integer(digits[0]) + get_integer(digits[-1])
      val.to_i
    end.sum
  end

  private

  def get_integer(val)
    if val.to_i == 0
      VALID_DIGITS[val].to_s
    else
      val
    end
  end
end
