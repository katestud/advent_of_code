defmodule ChecksumOne do

  def calculate(grid) do
    Enum.map(grid, fn(list) -> calculate_difference(list) end)
    |> Enum.reduce(fn(x, acc) -> x + acc end)
  end

  defp calculate_difference(list) do
    { min, max } = { Enum.min(list), Enum.max(list) }
    max - min
  end
end


defmodule ChecksumTwo do

  def calculate(grid) do
    Enum.map(grid, fn(list) -> find_evenly_divisible_values({nil, list}) end)
    |> Enum.reduce(fn(x, acc) -> round(x + acc) end)
  end

  defp find_evenly_divisible_values({nil, [head | tail]}) do
    value = Enum.find tail, 0, fn(x) ->
      (rem(x, head) == 0 || rem(head, x) == 0)
    end

    sorted = Enum.sort([value, head])
    case List.first(sorted) do
      0 -> find_evenly_divisible_values({nil, tail})
      first -> Enum.at(sorted, 1) / first
    end
  end
end
