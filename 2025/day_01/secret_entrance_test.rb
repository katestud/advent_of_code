require "minitest/autorun"
require_relative "secret_entrance"

class SecretEntranceTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 3, SecretEntrance.new("test_input.txt").execute_one

    assert_equal 1150, SecretEntrance.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 6, SecretEntrance.new("test_input.txt").execute_two

    assert_equal 6738, SecretEntrance.new("input.txt").execute_two
  end
end
