require "minitest/autorun"
require_relative "boat_races"

class BoatRaceTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 288, BoatRace.new("test_input.txt").execute_one

    assert_equal 440000, BoatRace.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 71503, BoatRace.new("test_input.txt").execute_two

    assert_equal 26187338, BoatRace.new("input.txt").execute_two
  end
end
