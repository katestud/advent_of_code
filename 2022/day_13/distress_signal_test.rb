require "minitest/autorun"
require_relative "distress_signal"

class DistressSignalTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 13, DistressSignal.new("test_input.txt").execute_one

    assert_equal 5938, DistressSignal.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 140, DistressSignal.new("test_input.txt").execute_two

    assert_equal 29025, DistressSignal.new("input.txt").execute_two
  end
end
