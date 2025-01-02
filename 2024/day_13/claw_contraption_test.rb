require "minitest/autorun"
require_relative "claw_contraption"

class ClawContraptionTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 480, ClawContraption.new("test_input.txt").execute_one

    puts "Part 1: #{ClawContraption.new("input.txt").execute_one}"
  end

  def test_that_part_two_works
    # assert_equal 0, ClawContraption.new("test_input.txt").execute_two

    assert_equal 0, ClawContraption.new("input.txt").execute_two
  end
end
