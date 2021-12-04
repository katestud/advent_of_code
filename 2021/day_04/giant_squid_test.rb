require "minitest/autorun"
require_relative "giant_squid"

class GiantSquidTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 4512, GiantSquid.new("test_input.txt").execute_one

    assert_equal 10374, GiantSquid.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 1924, GiantSquid.new("test_input.txt").execute_two

    assert_equal 0, GiantSquid.new("input.txt").execute_two
  end
end
