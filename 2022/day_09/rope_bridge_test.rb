require "minitest/autorun"
require_relative "rope_bridge"

class RopeBridgeTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 13, RopeBridge.new("test_input.txt").execute_one

    assert_equal 6470, RopeBridge.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 1, RopeBridge.new("test_input.txt").execute_two

    assert_equal 36, RopeBridge.new("test_input_two.txt").execute_two

    assert_equal 2658, RopeBridge.new("input.txt").execute_two
  end
end
