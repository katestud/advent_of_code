require "minitest/autorun"
require_relative "tuning_trouble"

class TuningTroubleTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 10, TuningTrouble.new("test_input.txt").execute_one

    assert_equal 1300, TuningTrouble.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 29, TuningTrouble.new("test_input.txt").execute_two

    assert_equal 3986, TuningTrouble.new("input.txt").execute_two
  end
end
