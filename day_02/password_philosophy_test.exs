Code.load_file("password_philosophy.exs", __DIR__)

ExUnit.start

defmodule PasswordPhilosophyTest do
  use ExUnit.Case

  test "calibrates the frequency" do
    freq = PasswordPhilosophy.analyze("test_input.txt")
    assert freq == 2

    freq = PasswordPhilosophy.analyze("input.txt")
    assert freq == 398
  end

end
