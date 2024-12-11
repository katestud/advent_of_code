require "minitest/autorun"
require_relative "plutonian_pebbles"

class PlutonianPebblesTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 55312, PlutonianPebbles.new("test_input.txt").execute_one

    assert_equal 0, PlutonianPebbles.new("input.txt").execute_one
  end

  def test_that_part_two_works
    # assert_equal 0, PlutonianPebbles.new("zero.txt").execute_two

    assert_equal 0, PlutonianPebbles.new("input.txt").execute_two
  end
end
