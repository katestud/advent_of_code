require "minitest/autorun"
require_relative "floor_is_lava"

class FloorIsLavaTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 46, FloorIsLava.new("test_input.txt").execute_one

    assert_equal 6622, FloorIsLava.new("input.txt").execute_one(start_dir: :down)
  end

  def test_that_part_two_works
    assert_equal 51, FloorIsLava.new("test_input.txt").execute_two

    assert_equal 7130, FloorIsLava.new("input.txt").execute_two
  end
end
