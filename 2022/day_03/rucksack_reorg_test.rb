require "minitest/autorun"
require_relative "rucksack_reorg"

class RucksackReorgTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 157, RucksackReorg.new("test_input.txt").execute_one

    assert_equal 7581, RucksackReorg.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 70, RucksackReorg.new("test_input.txt").execute_two

    assert_equal 2525, RucksackReorg.new("input.txt").execute_two
  end
end
