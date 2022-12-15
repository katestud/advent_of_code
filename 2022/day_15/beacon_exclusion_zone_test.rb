require "minitest/autorun"
require_relative "beacon_exclusion_zone"

class BeaconExclusionZoneTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 26, BeaconExclusionZone.new("test_input.txt", 10).execute_one

    assert_equal 5299855, BeaconExclusionZone.new("input.txt", 2000000).execute_one
  end

  def test_that_part_two_works
    assert_equal 56000011, BeaconExclusionZone.new("test_input.txt", 20).execute_two

    assert_equal 13615843289729, BeaconExclusionZone.new("input.txt", 4000000).execute_two
  end
end
