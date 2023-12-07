require "minitest/autorun"
require_relative "camel_cards"

class CamelCardsTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 6440, CamelCards.new("test_input.txt").execute_one

    assert_equal 253910319, CamelCards.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 5905, CamelCards.new("test_input.txt").execute_two

    assert_equal 254083736, CamelCards.new("input.txt").execute_two
  end
end
