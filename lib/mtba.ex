defmodule Mtba do
  @moduledoc """
  """

  @doc """

  copdepoints

  ["a", "a"]


  %{
    "a" => 1
  }

  """
  def count_chars(string) do
    string
    |> String.codepoints()
    |> Enum.reduce(%{}, fn character, acc ->
      case Map.get(acc, character) do
        nil -> Map.put(acc, character, 1)
        number -> Map.put(acc, character, number + 1)
      end
    end)
  end
end
