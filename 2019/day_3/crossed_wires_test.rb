require "minitest/autorun"
require_relative "crossed_wires"

class CrossedWiresTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 159, CrossedWires.new("test_input.txt").execute_one

    assert_equal 860, CrossedWires.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, CrossedWires.new("test_input.txt").execute_two

    # assert_equal 0, CrossedWires.new("input.txt").execute_two
  end
end
