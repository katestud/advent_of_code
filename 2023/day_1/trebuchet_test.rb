require "minitest/autorun"
require_relative "trebuchet"

class TrebuchetTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 142, Trebuchet.new("test_input.txt").execute_one

    assert_equal 54634, Trebuchet.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 281, Trebuchet.new("test_input_part_2.txt").execute_two

    assert_equal 53855, Trebuchet.new("input.txt").execute_two
  end
end

