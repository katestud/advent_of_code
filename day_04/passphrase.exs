defmodule PassphraseOne do

  def count_valid(file_path) do
    File.stream!(file_path)
    |> Stream.map( &(String.replace(&1, "\n", "")) )
    |> Enum.reduce(0, fn(str, acc) ->
      cond do
        valid_passphrase?(str) -> acc + 1
        true -> acc + 0
      end
    end)
  end

  def valid_passphrase?(passphrase) do
    String.split(passphrase, " ")
    |> each_phrase_unique?
  end

  def each_phrase_unique?(list) do
    each_phrase_unique?(list, MapSet.new)
  end

  defp each_phrase_unique?([head | []], found) do
    cond do
      MapSet.member?(found, head) -> false
      true -> true
    end
  end
  defp each_phrase_unique?([head | tail], found) do
    cond do
      MapSet.member?(found, head) -> false
      true -> each_phrase_unique?(tail, MapSet.put(found, head))
    end
  end

end
