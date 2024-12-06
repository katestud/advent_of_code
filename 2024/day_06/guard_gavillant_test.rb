require "minitest/autorun"
require_relative "guard_gavillant"

class GuardGavillantTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 41, GuardGavillant.new("test_input.txt").execute_one

    assert_equal 4778, GuardGavillant.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, GuardGavillant.new("test_input.txt").execute_two

    # assert_equal 0, GuardGavillant.new("input.txt").execute_two
  end
end
