require "minitest/autorun"
require_relative "syntax_scoring"

class SyntaxScoringTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 26397, SyntaxScoring.new("test_input.txt").execute_one

    assert_equal 290691, SyntaxScoring.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 288957, SyntaxScoring.new("test_input.txt").execute_two

    assert_equal 2768166558, SyntaxScoring.new("input.txt").execute_two
  end
end
