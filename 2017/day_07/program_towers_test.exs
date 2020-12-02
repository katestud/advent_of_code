Code.load_file("program_towers.exs", __DIR__)

ExUnit.start

defmodule ProgramTowersTest do
  use ExUnit.Case

  test "part one finds the base disc" do
    assert ProgramTowers.find_base_disc("program_towers_test_input.txt") == "tknk"
    assert ProgramTowers.find_base_disc("program_towers_input.txt") == "eugwuhl"
  end

end
