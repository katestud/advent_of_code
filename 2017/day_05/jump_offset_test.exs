Code.load_file("jump_offset.exs", __DIR__)

ExUnit.start

defmodule JumpOffsetTest do
  use ExUnit.Case

  test "part one find the number of jumps to exit maze" do
    instructions = [0, 3, 0, 1, -3]
    assert JumpOffsetOne.execute(instructions) == 5
  end

  test "part two increments offset differently" do
    instructions = [0, 3, 0, 1, -3]
    assert JumpOffsetTwo.execute(instructions) == 10
  end

end
