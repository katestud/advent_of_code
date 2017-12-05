defmodule InverseCaptchaOne do

  def calculate(string) do
    [head | tail] = String.graphemes(string)
    |> Enum.map(fn(n) -> String.to_integer(n) end)

    accumulate_matches(head, [head | tail], 0)
  end

  defp accumulate_matches(first, [ head | [ next | tail ] ], acc) when head == next do
    accumulate_matches(first, [next | tail], acc + head)
  end
  defp accumulate_matches(first, [ _ | [ next | tail ] ], acc) do
    accumulate_matches(first, [next | tail], acc)
  end
  defp accumulate_matches(first, [ head | [] ], acc) when first == head do
    acc + first
  end
  defp accumulate_matches(_, [ _ | [] ], acc) do
    acc
  end
end

defmodule InverseCaptchaTwo do

  def calculate(string) do
    list = String.graphemes(string)
    |> Enum.map(fn(n) -> String.to_integer(n) end)

    size = length(list)

    accumulate_matches(list, 0, size, round(size / 2), 0)
  end

  defp accumulate_matches(_, index, size, _, acc) when index == size do
    acc
  end
  defp accumulate_matches(list, index, size, steps, acc) when size > index + steps do
    { current, match } = { Enum.at(list, index),  Enum.at(list, index + steps) }
    cond do
      current == match ->
        accumulate_matches(list, index + 1, size, steps, acc + current)
      true ->
        accumulate_matches(list, index + 1, size, steps, acc)
    end
  end
  defp accumulate_matches(list, index, size, steps, acc) do
    { current, match } = { Enum.at(list, index),  Enum.at(list, index - steps) }
    cond do
      current == match ->
        accumulate_matches(list, index + 1, size, steps, acc + current)
      true ->
        accumulate_matches(list, index + 1, size, steps, acc)
    end
  end
end
