require "minitest/autorun"
require_relative "movie_theater"

class MovieTheaterTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 50, MovieTheater.new("test_input.txt").execute_one

    assert_equal 4776100539, MovieTheater.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, MovieTheater.new("test_input.txt").execute_two

    # assert_equal 0, MovieTheater.new("input.txt").execute_two
  end
end
