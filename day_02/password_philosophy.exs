# The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!"
# You ask if you can take a look.

# Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.

# To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.

# For example, suppose you have the following list:

# 1-3 a: abcde
# 1-3 b: cdefg
# 2-9 c: ccccccccc
# Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

# In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

# How many passwords are valid according to their policies?

# Part 2

# While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

# The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

# Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

# Given the same example list from above:

# 1-3 a: abcde is valid: position 1 contains a and position 3 does not.
# 1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
# 2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
# How many passwords are valid according to the new interpretation of the policies?

defmodule PasswordPhilosophy do

  def analyze_part1(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.map(&(extract_captures(&1)))
    |> Enum.count(&(validate_part1(&1)))
  end

  def analyze_part2(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.map(&(extract_captures(&1)))
    |> Enum.count(&(validate_part2(&1)))
  end

  defp validate_part1(nil), do: false
  defp validate_part1(%{"letter" => letter, "password" => password, "min" => min_count, "max" => max_count}) do
    count = String.codepoints(password)
    |> Enum.count(&(&1 == letter))

    count >= String.to_integer(min_count) && count <= String.to_integer(max_count)
  end

  defp validate_part2(nil), do: false
  defp validate_part2(%{"letter" => letter, "password" => password, "min" => min_position, "max" => max_position}) do
    index1 = String.to_integer(min_position) - 1
    index2 = String.to_integer(max_position) - 1

    match_count = [String.at(password, index1), String.at(password, index2)]
    |> Enum.count(fn a -> a == letter end)

    match_count == 1
  end

  defp extract_captures(line) do
    ~r/(?<min>\d+)-(?<max>\d+) (?<letter>.+): (?<password>.+)/
    |> Regex.named_captures(line)
  end

end
