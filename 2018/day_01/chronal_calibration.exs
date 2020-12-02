# After feeling like you've been falling for a few minutes, you look at the device's tiny screen. "Error: Device must be calibrated before first use. Frequency drift detected. Cannot maintain destination lock." Below the message, the device shows a sequence of changes in frequency (your puzzle input). A value like +6 means the current frequency increases by 6; a value like -3 means the current frequency decreases by 3.

# For example, if the device displays frequency changes of +1, -2, +3, +1, then starting from a frequency of zero, the following changes would occur:

# Current frequency  0, change of +1; resulting frequency  1.
# Current frequency  1, change of -2; resulting frequency -1.
# Current frequency -1, change of +3; resulting frequency  2.
# Current frequency  2, change of +1; resulting frequency  3.
# In this example, the resulting frequency is 3.

# Here are other example situations:

# +1, +1, +1 results in  3
# +1, +1, -2 results in  0
# -1, -2, -3 results in -6

# --- Part Two ---
# You notice that the device repeats the same frequency change list over and over. To calibrate the device, you need to find the first frequency it reaches twice. Note that your device might need to repeat its list of frequency changes many times before a duplicate frequency is found, and that duplicates might be found while in the middle of processing the list.


defmodule Frequency do

  def calibrate(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> find_duplicate_frequencies()
  end

  defp find_duplicate_frequencies(list) do
    find_duplicate_frequencies(list, list, 0, MapSet.new([0]))
  end

  defp find_duplicate_frequencies(initial, [], freq, found_frequencies) do
    find_duplicate_frequencies(initial, initial, freq, found_frequencies)
  end
  defp find_duplicate_frequencies(initial, [instruction | rest], freq, found_frequencies) do
    new_freq = adjust_frequency(String.at(instruction, 0), String.slice(instruction, 1..-1), freq)
    if MapSet.member?(found_frequencies, new_freq) do
      new_freq
    else
      found = MapSet.put(found_frequencies, new_freq)
      find_duplicate_frequencies(initial, rest, new_freq, found)
    end
  end

  defp adjust_frequency("+", increment, freq) do
    freq + String.to_integer(increment)
  end
  defp adjust_frequency("-", increment, freq) do
    freq - String.to_integer(increment)
  end

end
