# Here is an example batch file containing four passports:

# ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
# byr:1937 iyr:2017 cid:147 hgt:183cm

# iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
# hcl:#cfa07d byr:1929

# hcl:#ae17e1 iyr:2013
# eyr:2024
# ecl:brn pid:760753108 byr:1931
# hgt:179cm

# hcl:#cfa07d eyr:2025 pid:166559648
# iyr:2011 ecl:brn hgt:59in
# The first passport is valid - all eight fields are present. The second passport is invalid - it is missing hgt (the Height field).

# The third passport is interesting; the only missing field is cid, so it looks like data from North Pole Credentials, not a passport at all! Surely, nobody would mind if you made the system temporarily ignore missing cid fields. Treat this "passport" as valid.

# The fourth passport is missing two fields, cid and byr. Missing cid is fine, but missing any other field is not, so this passport is invalid.

# According to the above rules, your improved system would report 2 valid passports.

# Count the number of valid passports - those that have all required fields. Treat cid as optional. In your batch file, how many passports are valid?

defmodule PassportSystem do

  @eye_color ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  @hair_color_format ~r/[0-9a-f]/

  def count_valid_keys(file_path) do
    scrubbed_input(file_path)
    |> Enum.count(&valid?/1)
  end

  def count_valid_format(file_path) do
    scrubbed_input(file_path)
    |> Enum.count(&valid_format?/1)
  end

  defp valid?(%{"byr" => _byr, "iyr" => _iyr, "eyr" => _eyr, "hgt" => _hgt, "hcl" => _hcl, "ecl" => _ecl, "pid" => _pid}), do: true
  defp valid?(_), do: false

  defp valid_format?(%{"byr" => birth_year, "iyr" => issue_year, "eyr" => exp_year, "hgt" => height, "hcl" => hair_color, "ecl" => eye_color, "pid" => passport_id}) do
    valid_birth_year?(String.to_integer(birth_year)) &&
    valid_issue_year?(String.to_integer(issue_year)) &&
    valid_expiration_year?(String.to_integer(exp_year)) &&
    valid_height?(height) &&
    valid_hair_color?(hair_color) &&
    valid_eye_color?(eye_color) &&
    valid_passport_id?(passport_id)
  end
  defp valid_format?(_), do: false

  defp valid_year?(year), do: 4 == Integer.digits(year) |> Enum.count

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  defp valid_birth_year?(year), do: valid_year?(year) && Enum.member?(1920..2002, year)

  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  defp valid_issue_year?(year), do: valid_year?(year) && Enum.member?(2010..2020, year)

  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  defp valid_expiration_year?(year), do: valid_year?(year) && Enum.member?(2020..2030, year)

  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  defp valid_height?(height) do
     cond do
      String.ends_with?(height, "cm") ->
        num = String.trim(height, "cm") |> String.to_integer
        Enum.member?(150..193, num)
      String.ends_with?(height, "in") ->
        num = String.trim(height, "in") |> String.to_integer
        Enum.member?(59..76, num)
      true ->
        false
    end
  end

  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  defp valid_hair_color?(color) do
    String.starts_with?(color, "#") &&
    Regex.match?(@hair_color_format, color) &&
    String.length(color) == 7
  end

  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  defp valid_eye_color?(color), do: Enum.member?(@eye_color, color)

  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  defp valid_passport_id?(id), do: 9 == String.length(id) && Regex.match?(~r/[0-9]/, id)

  defp mapify(passport_data) when is_list(passport_data) do
    Enum.reduce(passport_data, [], fn(line, result) -> result ++ String.split(line, ":") end)
    |> Enum.chunk(2)
    |> Map.new(fn [k,  v] -> {k, v} end)
  end
  defp mapify(passport_data) do
    passport_data
    |> String.split([" ", "\n"])
    |> mapify
  end

  defp scrubbed_input(file_path) do
    File.read!(file_path)
    |> String.split("\n\n")
    |> Enum.map(&mapify/1)
  end

end
