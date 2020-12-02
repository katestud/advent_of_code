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

defmodule PassphraseTwo do

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
    |> has_anagrams?
    |> Kernel.not
  end

  defp has_anagrams?(list) do
    Enum.any?(list, fn(x) -> has_anagrams?(x, list) end)
  end
  defp has_anagrams?(item, list) do
    List.delete(list, item)
    |> Enum.any?(fn(x) -> is_anagram?(item, x) end)
  end

  defp is_anagram?(str1, str2) do
    cond do
      byte_size(str1) != byte_size(str2) -> false
      true -> sort_string(str1) == sort_string(str2)
    end
  end

  defp sort_string(str) do
    str |> String.graphemes |> Enum.sort |> Enum.join
  end

end
