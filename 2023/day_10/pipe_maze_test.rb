require "minitest/autorun"
require_relative "pipe_maze"

class PipeMazeTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 8, PipeMaze.new("test_input.txt").execute_one

    assert_equal 7086, PipeMaze.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, PipeMaze.new("test_input.txt").execute_two

    # assert_equal 0, PipeMaze.new("input.txt").execute_two
  end
end
