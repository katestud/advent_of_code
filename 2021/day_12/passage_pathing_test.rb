require "minitest/autorun"
require_relative "passage_pathing"

class PassagePathingTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 10, PassagePathing.new("test_input_0.txt").execute
    assert_equal 19, PassagePathing.new("test_input_1.txt").execute
    assert_equal 226, PassagePathing.new("test_input_2.txt").execute

    assert_equal 4573, PassagePathing.new("input.txt").execute
  end

  def test_that_part_two_works
    assert_equal 36, PassagePathing.new("test_input_0.txt").execute(part: 2)
    assert_equal 103, PassagePathing.new("test_input_1.txt").execute(part: 2)
    assert_equal 3509, PassagePathing.new("test_input_2.txt").execute(part: 2)

    # assert_equal 117509, PassagePathing.new("input.txt").execute(part: 2)
  end
end
