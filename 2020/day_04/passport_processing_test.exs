Code.load_file("passport_processing.exs", __DIR__)

ExUnit.start

defmodule PassportProcessingTest do
  use ExUnit.Case

  test "finds valid passport count for part 1" do
    assert 2 == PassportSystem.count_valid("test_input.txt")

    assert 230 == PassportSystem.count_valid("input.txt")
  end

end
