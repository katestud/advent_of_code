require "minitest/autorun"
require_relative "red_nosed_reports"

class RedNosedReportsTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 2, RedNosedReports.new("test_input.txt").execute_one

    assert_equal 0, RedNosedReports.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, RedNosedReports.new("test_input.txt").execute_two

    # assert_equal 0, RedNosedReports.new("input.txt").execute_two
  end
end
