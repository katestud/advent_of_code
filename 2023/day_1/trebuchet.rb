require_relative "../../src/toolkit"

class Trebuchet

  VALID_DIGITS = {
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    sum_digits(/\d/)
  end

  def execute_two
    # Positive lookahead with capturing to capture scenarios like "oneeight"
    regex_string = "(?=(" + VALID_DIGITS.keys.join("|") + "|\\d" + "))"
    sum_digits(Regexp.new(regex_string))
  end

  private

  def sum_digits(regex)
    @input.map do |line|
      digits = line.downcase.scan(regex).flatten
      val = int_string(digits[0]) + int_string(digits[-1])
      val.to_i
    end.sum
  end

  def int_string(val)
    VALID_DIGITS[val] || val
  end
end
