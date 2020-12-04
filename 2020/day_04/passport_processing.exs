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
  def count_valid(file_path) do
    File.read!(file_path)
    |> String.split("\n\n")
    |> Enum.map(&mapify/1)
    |> Enum.count(&valid?/1)
  end

  defp valid?(%{"byr" => birth_year, "iyr" => issue_year, "eyr" => exp_year, "hgt" => height, "hcl" => hair_color, "ecl" => eye_color, "pid" => passport_id}), do: true
  defp valid?(_), do: false

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

end
