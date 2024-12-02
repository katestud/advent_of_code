require "minitest/autorun"
require_relative "lens_library"

class LensLibraryTest < Minitest::Test

  def test_hash_algorithm
    assert_equal 52, LensString.new("HASH").hash_value
    assert_equal 231, LensString.new("ot=7").hash_value
    assert_equal 0, LensString.new("rn").hash_value
    assert_equal 1, LensString.new("qp").hash_value
    assert_equal 3, LensString.new("pc").hash_value
  end

  def test_that_part_one_works
    assert_equal 1320, LensLibrary.new("test_input.txt").execute_one

    assert_equal 508498, LensLibrary.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 145, LensLibrary.new("test_input.txt").execute_two

    assert_equal 279116, LensLibrary.new("input.txt").execute_two
  end
end
