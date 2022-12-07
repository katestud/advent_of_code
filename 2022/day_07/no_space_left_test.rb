require "minitest/autorun"
require_relative "no_space_left"

class NoSpaceLeftTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 95437, NoSpaceLeft.new("test_input.txt").execute_one

    assert_equal 1306611, NoSpaceLeft.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, NoSpaceLeft.new("test_input.txt").execute_two

    # assert_equal 0, NoSpaceLeft.new("input.txt").execute_two
  end
end
