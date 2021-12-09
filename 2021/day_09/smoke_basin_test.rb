require "minitest/autorun"
require_relative "smoke_basin"

class SmokeBasinTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 15, SmokeBasin.new("test_input.txt").execute_one

    assert_equal 423, SmokeBasin.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 1134, SmokeBasin.new("test_input.txt").execute_two

    assert_equal 1198704, SmokeBasin.new("input.txt").execute_two
  end
end
