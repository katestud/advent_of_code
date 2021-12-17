require "minitest/autorun"
require_relative "trick_shot"

class TrickShotTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 45, TrickShot.new("test_input.txt").execute_one

    assert_equal 5671, TrickShot.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 112, TrickShot.new("test_input.txt").execute_two

    assert_equal 4556, TrickShot.new("input.txt").execute_two
  end
end
