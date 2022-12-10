require "minitest/autorun"
require_relative "cathode_ray_tube"

class CathodeRayTubeTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 13140, CathodeRayTube.new("test_input.txt").execute_one

    assert_equal 14240, CathodeRayTube.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_nil CathodeRayTube.new("test_input.txt").execute_two

    assert_nil CathodeRayTube.new("input.txt").execute_two
  end
end
