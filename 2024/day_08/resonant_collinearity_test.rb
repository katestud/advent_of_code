require "minitest/autorun"
require_relative "resonant_collinearity"

class ResonantCollinearityTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 14, ResonantCollinearity.new("test_input.txt").execute_one

    assert_equal 249, ResonantCollinearity.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 34, ResonantCollinearity.new("test_input.txt").execute_two

    assert_equal 905, ResonantCollinearity.new("input.txt").execute_two
  end
end
