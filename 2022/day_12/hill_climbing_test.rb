require "minitest/autorun"
require_relative "hill_climbing"

class HillClimbingTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 31, HillClimbing.new("test_input.txt").execute_one

    assert_equal 394, HillClimbing.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 29, HillClimbing.new("test_input.txt").execute_two

    assert_equal 388, HillClimbing.new("input.txt").execute_two
  end
end
