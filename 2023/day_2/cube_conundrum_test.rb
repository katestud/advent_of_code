require "minitest/autorun"
require_relative "cube_conundrum"

class CubeConundrumTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 8, CubeConundrum.new("test_input.txt").execute_one

    assert_equal 0, CubeConundrum.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, CubeConundrum.new("test_input.txt").execute_two

    # assert_equal 0, CubeConundrum.new("input.txt").execute_two
  end
end
