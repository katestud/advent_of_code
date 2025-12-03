require "minitest/autorun"
require_relative "lobby"

class LobbyTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 357, Lobby.new("test_input.txt").execute_one

    assert_equal 0, Lobby.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, Lobby.new("test_input.txt").execute_two

    # assert_equal 0, Lobby.new("input.txt").execute_two
  end
end
