require "minitest/autorun"
require_relative "scratchcards"

class ScratchcardsTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 13, Scratchcards.new("test_input.txt").execute_one

    assert_equal 18653, Scratchcards.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 30, Scratchcards.new("test_input.txt").execute_two

    assert_equal 5921508, Scratchcards.new("input.txt").execute_two
  end
end
