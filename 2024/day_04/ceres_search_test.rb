require "minitest/autorun"
require_relative "ceres_search"

class CeresSearchTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 18, CeresSearch.new("test_input.txt").execute_one

    puts "Part 1: #{CeresSearch.new("input.txt").execute_one}"
  end

  def test_that_part_two_works
    assert_equal 9, CeresSearch.new("test_input.txt").execute_two

    puts "Part 2: #{CeresSearch.new("input.txt").execute_two}"
  end
end
