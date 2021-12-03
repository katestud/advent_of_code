require "minitest/autorun"
require_relative "binary_diagnostic"

class BinaryDiagnosticTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 198, BinaryDiagnostic.new("test_input.txt").execute_one

    assert_equal 3549854, BinaryDiagnostic.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 230, BinaryDiagnostic.new("test_input.txt").execute_two

    assert_equal 3765399, BinaryDiagnostic.new("input.txt").execute_two
  end
end
