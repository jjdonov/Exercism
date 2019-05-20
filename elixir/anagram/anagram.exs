defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    downcase_base = String.downcase(base)
    base_count = count(base)

    Enum.filter(candidates, fn candidate ->
      downcase_base != String.downcase(candidate) && base_count == count(candidate)
    end)
  end

  def count(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce(%{}, fn char, acc ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
  end
end
