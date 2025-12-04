require "minitest/autorun"
require_relative "printing_department"

class PrintingDepartmentTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 13, PrintingDepartment.new("test_input.txt").execute_one

    assert_equal 1523, PrintingDepartment.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 43, PrintingDepartment.new("test_input.txt").execute_two

    assert_equal 0, PrintingDepartment.new("input.txt").execute_two
  end
end
