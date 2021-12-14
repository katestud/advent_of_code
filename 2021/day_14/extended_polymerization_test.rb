require "minitest/autorun"
require_relative "extended_polymerization"

class ExtendedPolymerizationTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 1588, ExtendedPolymerization.new("test_input.txt").execute_one

    assert_equal 2509, ExtendedPolymerization.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, ExtendedPolymerization.new("test_input.txt").execute_two

    # assert_equal 0, ExtendedPolymerization.new("input.txt").execute_two
  end
end
