Code.load_file("password_philosophy.exs", __DIR__)

ExUnit.start

defmodule PasswordPhilosophyTest do
  use ExUnit.Case

  test "finds valid password count for part 1" do
    freq = PasswordPhilosophy.analyze_part1("test_input.txt")
    assert freq == 2

    freq = PasswordPhilosophy.analyze_part1("input.txt")
    assert freq == 398
  end

  test "finds valid password count for part 2" do
    freq = PasswordPhilosophy.analyze_part2("test_input.txt")
    assert freq == 1

    freq = PasswordPhilosophy.analyze_part2("input.txt")
    assert freq == 562
  end

end
