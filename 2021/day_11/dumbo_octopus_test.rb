require "minitest/autorun"
require_relative "dumbo_octopus"

class DumboOctopusTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 1656, DumboOctopus.new("test_input.txt").execute_one

    assert_equal 1640, DumboOctopus.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 195, DumboOctopus.new("test_input.txt").execute_two

    assert_equal 312, DumboOctopus.new("input.txt").execute_two
  end
end
