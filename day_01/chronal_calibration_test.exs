Code.load_file("chronal_calibration.exs", __DIR__)

ExUnit.start

defmodule FrequencyTest do
  use ExUnit.Case

  test "calibrates the frequency" do
    freq = Frequency.calibrate("test_input.txt")
    assert freq == 3

    freq = Frequency.calibrate("input.txt")
    assert freq == 454
  end

end
