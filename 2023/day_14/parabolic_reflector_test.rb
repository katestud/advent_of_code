require "minitest/autorun"
require_relative "parabolic_reflector"

class ParabolicReflectorTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 136, ParabolicReflector.new("test_input.txt").execute_one

    assert_equal 110407, ParabolicReflector.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 64, ParabolicReflector.new("test_input.txt").execute_two

    assert_equal 87273, ParabolicReflector.new("input.txt").execute_two
  end
end
