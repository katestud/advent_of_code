require "minitest/autorun"
require_relative "regolith_reservoir"

class RegolithReservoirTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 24, RegolithReservoir.new("test_input.txt").execute_one

    assert_equal 655, RegolithReservoir.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 93, RegolithReservoir.new("test_input.txt").execute_two

    assert_equal 26484, RegolithReservoir.new("input.txt").execute_two
  end
end
