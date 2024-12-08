require "minitest/autorun"
require_relative "resonant_collinearity"

class ResonantCollinearityTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 14, ResonantCollinearity.new("test_input.txt").execute_one

    assert_equal 0, ResonantCollinearity.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, ResonantCollinearity.new("test_input.txt").execute_two

    # assert_equal 0, ResonantCollinearity.new("input.txt").execute_two
  end
end
