require "minitest/autorun"
require_relative "packet_decoder"

class PacketDecoderTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 16, PacketDecoder.new("test_input_0.txt").execute_one
    assert_equal 12, PacketDecoder.new("test_input_1.txt").execute_one
    assert_equal 23, PacketDecoder.new("test_input_2.txt").execute_one
    assert_equal 31, PacketDecoder.new("test_input_3.txt").execute_one

    assert_equal 871, PacketDecoder.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, PacketDecoder.new("test_input_0.txt").execute_two

    # assert_equal 0, PacketDecoder.new("input.txt").execute_two
  end
end
