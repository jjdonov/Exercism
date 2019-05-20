defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    cleaned =
      String.upcase(sentence)
      |> String.replace(~r/[^A-Z]/, "")
      |> String.to_charlist()

    Enum.uniq(cleaned) == cleaned
  end
end
