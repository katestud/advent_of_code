defmodule BinaryBoarding do

#   Enum.chunk_every([1, 2, 3, 4, 5], 2, 3, [])
# [[1, 2], [4, 5]]

  @row_range Enum.to_list(0..127)
  @column_range Enum.to_list(0..7)

  def max_id(filename) do
    input(filename)
    |> Enum.map(&seat_id/1)
    |> Enum.max
  end

  def missing_id(filename) do
    ids = input(filename)
    |> Enum.map(&seat_id/1)
    |> Enum.sort
    |> Enum.reverse

    [highest | _] = ids

    missing?(highest, ids)
  end

  defp missing?(num, collection) do
    cond do
      Enum.member?(collection, num) ->
        missing?(num - 1, collection)
      true ->
        num
    end
  end

  defp seat_id(<<row::bytes-size(7)>> <> <<column::bytes-size(3)>>) do
    row(row) * 8 + column(column)
  end
  defp seat_id(_), do: 0

  defp row(row) do
    row(String.codepoints(row), @row_range)
  end

  defp row([], [range_head | _]) do
    range_head
  end
  defp row([row_head | row_tail], range) do
    new_range = row(row_head, range)
    row(row_tail, new_range)
  end

  defp row("B", range) do
    [_lower, upper] = Enum.chunk_every(range, trunc(length(range) / 2))
    upper
  end
  defp row("F", range) do
    [lower | _upper] = Enum.chunk_every(range, trunc(length(range) / 2))
    lower
  end

  defp column(column) do
    column(String.codepoints(column), @column_range)
  end

  defp column([], [range_head | _]) do
    range_head
  end
  defp column([column_head | column_tail], range) do
    new_range = column(column_head, range)
    column(column_tail, new_range)
  end

  defp column("R", range) do
    [_lower, upper] = Enum.chunk_every(range, trunc(length(range) / 2))
    upper
  end
  defp column("L", range) do
    [lower | _upper] = Enum.chunk_every(range, trunc(length(range) / 2))
    lower
  end

  defp input(filename) do
    File.read!(filename)
    |> String.split("\n")
  end
end
