require "minitest/autorun"
require_relative "haunted_wasteland"

class HauntedWastelandTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 6, HauntedWasteland.new("test_input.txt").execute_one

    assert_equal 20513, HauntedWasteland.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 6, HauntedWasteland.new("test_input_part_2.txt").execute_two

    assert_equal 15995167053923, HauntedWasteland.new("input.txt").execute_two
  end
end
