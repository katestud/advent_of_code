Code.require_file("passport_processing.exs", __DIR__)

ExUnit.start

defmodule PassportProcessingTest do
  use ExUnit.Case

  test "finds valid passport count for part 1" do
    assert 2 == PassportSystem.count_valid_keys("test_input.txt")

    assert 230 == PassportSystem.count_valid_keys("input.txt")
  end

  test "finds valid passport format count for part 2" do
    assert 4 == PassportSystem.count_valid_format("part2_test_input.txt")

    assert 156 == PassportSystem.count_valid_format("input.txt")
  end

end
