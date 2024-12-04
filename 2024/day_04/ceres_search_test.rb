require "minitest/autorun"
require_relative "ceres_search"

class CeresSearchTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 18, CeresSearch.new("test_input.txt").execute_one

    assert_equal 0, CeresSearch.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, CeresSearch.new("test_input.txt").execute_two

    # assert_equal 0, CeresSearch.new("input.txt").execute_two
  end
end
