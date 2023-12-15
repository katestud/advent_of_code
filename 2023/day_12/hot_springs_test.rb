require "minitest/autorun"
require_relative "hot_springs"

class HotSpringsTest < Minitest::Test

  def test_arrangements
    hot_springs = HotSprings.new

    assert_equal 1, hot_springs.count_arrangements("???.### 1,1,3")
    assert_equal 4, hot_springs.count_arrangements(".??..??...?##. 1,1,3")
    assert_equal 1, hot_springs.count_arrangements("?#?#?#?#?#?#?#? 1,3,1,6")
    assert_equal 1, hot_springs.count_arrangements("????.#...#... 4,1,1")
    assert_equal 4, hot_springs.count_arrangements("????.######..#####. 1,6,5")
    assert_equal 10, hot_springs.count_arrangements("?###???????? 3,2,1")
  end

  def test_that_part_one_works
    assert_equal 21, HotSprings.new("test_input.txt").execute_one

    assert_equal 7260, HotSprings.new("input.txt").execute_one
  end

  def test_that_part_two_works
    # assert_equal 0, HotSprings.new("test_input.txt").execute_two

    # assert_equal 0, HotSprings.new("input.txt").execute_two
  end
end
