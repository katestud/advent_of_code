require "minitest/autorun"
require_relative "oasis"

class OasisTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 114, Oasis.new("test_input.txt").execute_one

    assert_equal 1987402313, Oasis.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 2, Oasis.new("test_input.txt").execute_two

    assert_equal 900, Oasis.new("input.txt").execute_two
  end
end
