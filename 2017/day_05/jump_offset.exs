defmodule JumpOffsetOne do

  def execute(instructions) do
    follow_jumps(instructions, 0, 1)
  end

  defp follow_jumps(list, index, count) do
    offset = Enum.at(list, index)
    cond do
      Enum.at(list, offset + index) ->
        List.update_at(list, index, &(&1 + 1))
        |> follow_jumps(index + offset, count + 1)
      true ->
        count
    end
  end

end

defmodule JumpOffsetTwo do

  def execute(instructions) do
    follow_jumps(instructions, 0, 1)
  end

  defp follow_jumps(_, index, count) when index < 0, do: count
  defp follow_jumps(list, index, count) do
    offset = Enum.at(list, index)
    cond do
      Enum.at(list, offset + index) ->
        List.update_at(list, index, &(update_offset(&1)))
        |> follow_jumps(index + offset, count + 1)
      true ->
        count
    end
  end

  defp update_offset(offset) when offset >= 3, do: offset - 1
  defp update_offset(offset), do: offset + 1
end
