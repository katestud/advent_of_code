require "minitest/autorun"
require_relative "rock_paper_scissors"

class RockPaperScissorsTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 15, RockPaperScissors.new("test_input.txt").execute_one

    assert_equal 11906, RockPaperScissors.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 12, RockPaperScissors.new("test_input.txt").execute_two

    assert_equal 11186, RockPaperScissors.new("input.txt").execute_two
  end
end
