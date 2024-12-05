require "minitest/autorun"
require_relative "print_queue"

class PrintQueueTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 143, PrintQueue.new("test_input.txt").execute_one

    puts "Part 1: #{PrintQueue.new("input.txt").execute_one}"
  end

  def test_that_part_two_works
    assert_equal 123, PrintQueue.new("test_input.txt").execute_two

   puts "Part 2: #{PrintQueue.new("input.txt").execute_two}"
  end
end
