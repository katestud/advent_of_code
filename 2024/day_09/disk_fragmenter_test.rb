require "minitest/autorun"
require_relative "disk_fragmenter"

class DiskFragmenterTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 1928, DiskFragmenter.new("test_input.txt").execute_one

    assert_equal 0, DiskFragmenter.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, DiskFragmenter.new("test_input.txt").execute_two

    # assert_equal 0, DiskFragmenter.new("input.txt").execute_two
  end
end
