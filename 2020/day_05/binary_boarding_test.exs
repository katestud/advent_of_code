Code.require_file("binary_boarding.exs", __DIR__)

ExUnit.start

defmodule BinaryBoardingTest do
  use ExUnit.Case

  test "finds highest seat id" do
    assert 820 == BinaryBoarding.max_id("test_input.txt")

    assert 904 == BinaryBoarding.max_id("input.txt")
  end

  test "finds missing seat id" do
    assert 669 == BinaryBoarding.missing_id("input.txt")
  end
end
