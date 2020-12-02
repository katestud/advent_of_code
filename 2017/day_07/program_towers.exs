defmodule TowerInput do
  defstruct name: "a", weight: 1, supports: []
end

defmodule ProgramTowers do

  def find_base_disc(file_path) do
    File.stream!(file_path)
    |> Stream.map(&(String.replace(&1, "\n", "")) )
    |> Enum.map(fn(input) -> build_struct(input) end)
    |> Enum.filter(fn(input) -> supporting_disc?(input) end)
    |> find_base_name
  end

  defp build_struct(input) do
    [ name | [ weight | supports ] ] = input
    |> String.split([" ", "(", ")", "->", ","], trim: true)

    %TowerInput{name: name, weight: String.to_integer(weight), supports: supports}
  end

  defp supporting_disc?(%TowerInput{supports: supports}) do
    length(supports) > 0
  end

  defp is_supported?(discs, %TowerInput{name: name}) do
    discs
    |> Enum.any?(fn(disc) -> Enum.member?(disc.supports, name) end)
  end

  defp find_base_name(supporting_discs) do
    [%TowerInput{name: name}] =
      Enum.reject(supporting_discs, fn(input) -> is_supported?(supporting_discs, input) end)

    name
  end
end
