require "minitest/autorun"
require_relative "gift_shop"

class GiftShopTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 1227775554, GiftShop.new("test_input.txt").execute_one

    assert_equal 0, GiftShop.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, GiftShop.new("test_input.txt").execute_two

    # assert_equal 0, GiftShop.new("input.txt").execute_two
  end
end
