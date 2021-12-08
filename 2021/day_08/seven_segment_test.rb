require "minitest/autorun"
require_relative "seven_segment"

class SevenSegmentTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 26, SevenSegment.new("test_input.txt").execute_one

    assert_equal 493, SevenSegment.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 61229, SevenSegment.new("test_input.txt").execute_two

    assert_equal 1010460, SevenSegment.new("input.txt").execute_two
  end
end
