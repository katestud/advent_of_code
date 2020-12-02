defmodule MemoryAllocator do

  def redistribute(state, seen \\ [], count \\ 0) do
    find_max_bank(state)
    |> distribute_blocks(state)
    |> update_seen(seen, count + 1)
  end

  defp update_seen(state, seen, count) do
    cond do
      state_previously_seen?(state, seen) -> count
      true -> redistribute(state, [state | seen], count)
    end
  end

  defp find_max_bank(state) do
    list = Tuple.to_list(state)
    max = Enum.max(list)

    index = list
    |> Enum.find_index(fn(x) -> max == x end)
    {max, index}
  end

  defp distribute_blocks({to_distribute, index}, state) do
    Tuple.to_list(state)
    |> update_banks(to_distribute, index)
    |> List.to_tuple
  end

  defp update_banks(list, to_distribute, index) do
    list_size = length(list)
    value_to_update = [div(to_distribute, list_size - 1), 1] |> Enum.max
    list
    |> List.replace_at(index, 0)
    |> update_bank(to_distribute, index + 1, value_to_update, list_size)
  end

  defp update_bank(list, to_distribute, _, _, _) when to_distribute == 0 do
    list
  end
  defp update_bank(list, to_distribute, index, value_to_update, list_size) when value_to_update >= to_distribute do
    list
    |> List.update_at(index - list_size, &(&1 + to_distribute))
    |> update_bank(0, index + 1, value_to_update, list_size)
  end
  defp update_bank(list, to_distribute, index, value_to_update, list_size) do
    list
    |> List.update_at(index - list_size, &(&1 + value_to_update))
    |> update_bank(to_distribute - value_to_update, index + 1, value_to_update, list_size)
  end

  defp state_previously_seen?(state, seen) do
    seen
    |> Enum.any?(fn prev_state -> prev_state == state end)
  end

end
