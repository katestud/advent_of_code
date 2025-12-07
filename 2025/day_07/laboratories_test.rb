require "minitest/autorun"
require_relative "laboratories"

class LaboratoriesTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 21, Laboratories.new("test_input.txt").execute_one

    assert_equal 1602, Laboratories.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, Laboratories.new("test_input.txt").execute_two

    # assert_equal 0, Laboratories.new("input.txt").execute_two
  end
end
