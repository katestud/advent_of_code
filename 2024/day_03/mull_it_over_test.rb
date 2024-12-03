require "minitest/autorun"
require_relative "mull_it_over"

class MullItOverTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 161, MullItOver.new("test_input.txt").execute_one

    puts "Part One: #{MullItOver.new("input.txt").execute_one}"
  end

  def test_that_part_two_works
    assert_equal 48, MullItOver.new("test_input_2.txt").execute_two

    puts "Part Two: #{MullItOver.new("input.txt").execute_two}"
  end
end
