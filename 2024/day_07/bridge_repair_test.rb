require "minitest/autorun"
require_relative "bridge_repair"

class BridgeRepairTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 3749, BridgeRepair.new("test_input.txt").execute_one

    assert_equal 0, BridgeRepair.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 11387, BridgeRepair.new("test_input.txt").execute_two

    assert_equal 0, BridgeRepair.new("input.txt").execute_two
  end
end
