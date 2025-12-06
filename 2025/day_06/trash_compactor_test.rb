require "minitest/autorun"
require_relative "trash_compactor"

class TrashCompactorTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 4277556, TrashCompactor.new("test_input.txt").execute_one

    assert_equal 6295830249262, TrashCompactor.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, TrashCompactor.new("test_input.txt").execute_two

    # assert_equal 0, TrashCompactor.new("input.txt").execute_two
  end
end
