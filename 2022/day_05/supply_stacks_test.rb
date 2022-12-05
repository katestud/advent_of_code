require "minitest/autorun"
require_relative "supply_stacks"

class SupplyStacksTest < Minitest::Test

  def test_that_part_one_works
    assert_equal "CMZ", SupplyStacks.new("test_input.txt").execute_one

    assert_equal "GRTSWNJHH", SupplyStacks.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 'MCD', SupplyStacks.new("test_input.txt").execute_two

    assert_equal "", SupplyStacks.new("input.txt").execute_two
  end
end
