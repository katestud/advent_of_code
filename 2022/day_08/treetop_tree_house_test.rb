require "minitest/autorun"
require_relative "treetop_tree_house"

class TreetopTreeHouseTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 21, TreetopTreeHouse.new("test_input.txt").execute_one

    assert_equal 1693, TreetopTreeHouse.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 8, TreetopTreeHouse.new("test_input.txt").execute_two

    assert_equal 422059, TreetopTreeHouse.new("input.txt").execute_two
  end
end
