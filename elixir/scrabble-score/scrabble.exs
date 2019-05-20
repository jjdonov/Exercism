defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.trim
    |> String.graphemes
    |> Enum.reduce(0, &(score_grapheme(&1) + &2))
  end

  def score_grapheme(grapheme) do
    matches? = &(String.match?(grapheme, &1))
    cond do
      matches?.(~r/[aAeEiIoOuUlLnNrRsStT]/) ->
        1
      matches?.(~r/[dDgG]/) ->
        2
      matches?.(~r/[bBcCmMpP]/) ->
        3
      matches?.(~r/[fFhHvVwWyY]/) ->
        4
      matches?.(~r/[kK]/) ->
        5
      matches?.(~r/[jJxX]/) ->
        8
      matches?.(~r/[qQzZ]/) ->
        10
      true ->
        0
    end
  end
end
