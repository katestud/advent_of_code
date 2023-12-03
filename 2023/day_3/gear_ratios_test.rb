require "minitest/autorun"
require_relative "gear_ratios"

class GearRatiosTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 4361, GearRatios.new("test_input.txt").execute_one

    assert_equal 531932, GearRatios.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 467835, GearRatios.new("test_input.txt").execute_two

    assert_equal 0, GearRatios.new("input.txt").execute_two
  end
end
