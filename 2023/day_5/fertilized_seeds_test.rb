require "minitest/autorun"
require_relative "fertilized_seeds"

class FertilizedSeedsTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 35, FertilizedSeeds.new("test_input.txt").execute_one

    assert_equal 1181555926, FertilizedSeeds.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 46, FertilizedSeeds.new("test_input.txt").execute_two

    assert_equal 37806486, FertilizedSeeds.new("input.txt").execute_two
  end
end
