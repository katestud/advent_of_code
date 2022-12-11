require "minitest/autorun"
require_relative "monkey_business"

class MonkeyBusinessTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 10605, MonkeyBusiness.new("test_input.txt").execute_one

    assert_equal 56595, MonkeyBusiness.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 2713310158, MonkeyBusiness.new("test_input.txt").execute_two

    assert_equal 0, MonkeyBusiness.new("input.txt").execute_two
  end
end
