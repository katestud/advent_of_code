Code.load_file("register.exs", __DIR__)

ExUnit.start

defmodule RegisterTest do
  use ExUnit.Case

  test "finds the current largest and alltime largest value" do
    {current, alltime} = Register.execute("register_test_input.txt")
    assert current == 1
    assert alltime == 10
  end

end
