require "minitest/autorun"
require_relative "parabolic_reflector"

class ParabolicReflectorTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 136, ParabolicReflector.new("test_input.txt").execute_one

    assert_equal 0, ParabolicReflector.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, ParabolicReflector.new("test_input.txt").execute_two

    # assert_equal 0, ParabolicReflector.new("input.txt").execute_two
  end
end