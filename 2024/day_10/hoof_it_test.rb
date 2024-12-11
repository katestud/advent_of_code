require "minitest/autorun"
require_relative "hoof_it"

class HoofItTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 36, HoofIt.new("test_input.txt").execute_one

    assert_equal 0, HoofIt.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, HoofIt.new("test_input.txt").execute_two

    # assert_equal 0, HoofIt.new("input.txt").execute_two
  end
end
