require "minitest/autorun"
require_relative "points_of_incidence"

class IncidencePointsTest < Minitest::Test

  def test_that_column_detection_works
    column_pattern = [[".", ".", ".", "#", "#", "#", ".", ".", ".", ".", "#", "#", "#", ".", "."], ["#", "#", ".", ".", ".", "#", ".", ".", ".", ".", "#", ".", ".", ".", "#"], [".", ".", "#", ".", "#", ".", "#", ".", ".", "#", ".", "#", ".", "#", "."], [".", ".", ".", "#", ".", "#", ".", "#", "#", ".", "#", ".", "#", ".", "."], ["#", "#", "#", "#", ".", ".", ".", ".", ".", ".", ".", ".", "#", "#", "#"], [".", ".", ".", ".", "#", "#", "#", "#", "#", "#", "#", "#", ".", ".", "."], ["#", "#", "#", "#", ".", ".", ".", ".", ".", ".", ".", ".", "#", "#", "#"], ["#", "#", "#", "#", ".", "#", ".", ".", ".", ".", "#", ".", "#", "#", "#"], ["#", "#", "#", "#", ".", "#", "#", "#", "#", "#", "#", ".", "#", "#", "#"], ["#", "#", "#", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "#", "#"], [".", ".", "#", "#", ".", "#", "#", ".", ".", "#", "#", ".", "#", "#", "."], [".", ".", "#", ".", "#", ".", ".", "#", "#", ".", ".", "#", ".", "#", "."], [".", ".", "#", ".", "#", ".", "#", "#", "#", "#", ".", "#", "#", "#", "."]]
    mirror = ColumnMirror.new(column_pattern, false)
    assert_equal true, mirror.valid?
    assert_equal 1, mirror.score

    mirror = ColumnMirror.new(column_pattern, true)
    assert_equal true, mirror.valid?
    assert_equal 8, mirror.score
  end

  def test_that_part_one_works
    assert_equal 405, IncidencePoints.new("test_input.txt").execute_one

    assert_equal 33780, IncidencePoints.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 400, IncidencePoints.new("test_input.txt").execute_two

    assert_equal 23479, IncidencePoints.new("input.txt").execute_two
  end
end
