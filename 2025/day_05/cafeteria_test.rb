require "minitest/autorun"
require_relative "cafeteria"

class CafeteriaTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 3, Cafeteria.new("test_input.txt").execute_one

    assert_equal 525, Cafeteria.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, Cafeteria.new("test_input.txt").execute_two

    # assert_equal 0, Cafeteria.new("input.txt").execute_two
  end
end
