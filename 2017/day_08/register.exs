defmodule Register do

  def execute(file_path) do
    {max, map} = File.stream!(file_path)
    |> Stream.map(&(String.replace(&1, "\n", "")) )
    |> Enum.map(&(String.split(&1)))
    |> execute_instructions

    {find_largest_value(map), max}
  end

  defp execute_instructions(instructions), do: execute_instructions(instructions, %{}, 0)
  defp execute_instructions([current_step | []], map, max) do
    update_map(current_step, map, max)
  end
  defp execute_instructions([current_step | rest], map, max) do
    {new_max, new_map} = update_map(current_step, map, max)
    execute_instructions(rest, new_map, new_max)
  end

  defp update_map([var_name, add_or_sub, incrementor, _, compared_var, comparator, compared_val], map, max) do
    current_val = map[var_name] || 0
    inc = if add_or_sub == "inc", do: "+", else: "-"
    current_compared_val = map[compared_var] || 0
    string_code = "if #{current_compared_val} #{comparator} #{compared_val}, do: #{current_val} #{inc} #{incrementor}, else: #{current_val}"
    quoted_instruction = Code.string_to_quoted(string_code)
    {{:ok, val}, _} = Code.eval_quoted(quoted_instruction)

    new_map = Map.put(map, var_name, val)
    new_max = Enum.max([max, val])
    {new_max, new_map}
  end

  defp find_largest_value(map) do
    map
    |> Map.values
    |> Enum.max
  end

end
