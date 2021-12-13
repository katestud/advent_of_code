require "minitest/autorun"
require_relative "transparent_origami"

class TransparentOrigamiTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 17, TransparentOrigami.new("test_input.txt").execute_one

    assert_equal 695, TransparentOrigami.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_nil TransparentOrigami.new("test_input.txt").execute_two

    assert_nil TransparentOrigami.new("input.txt").execute_two
  end
end
