require "minitest/autorun"
require_relative "calorie_counting"

class CalorieCounterTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 24000, CalorieCounter.new("test_input.txt").execute_one

    assert_equal 67027, CalorieCounter.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 45000, CalorieCounter.new("test_input.txt").execute_two

    assert_equal 197291, CalorieCounter.new("input.txt").execute_two
  end
end
