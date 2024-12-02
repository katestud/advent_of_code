require "minitest/autorun"
require_relative "historian_hysteria"

class HistorianHysteriaTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 11, HistorianHysteria.new("test_input.txt").execute_one

    assert_equal 2113135, HistorianHysteria.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, HistorianHysteria.new("test_input.txt").execute_two

    # assert_equal 0, HistorianHysteria.new("input.txt").execute_two
  end
end
