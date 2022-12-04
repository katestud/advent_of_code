require "minitest/autorun"
require_relative "camp_cleanup"

class CampCleanupTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 2, CampCleanup.new("test_input.txt").execute_one

    assert_equal 595, CampCleanup.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 4, CampCleanup.new("test_input.txt").execute_two

    assert_equal 952, CampCleanup.new("input.txt").execute_two
  end
end
