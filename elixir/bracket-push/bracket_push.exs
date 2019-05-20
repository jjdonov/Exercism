defmodule BracketPush do
  @openings ["[", "{", "("]
  @closings ["]", "}", ")"]
  @pairs Enum.concat(Enum.zip(@openings, @closings), Enum.zip(@closings, @openings))
         |> Enum.into(%{})

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    consume(String.graphemes(str), [])
  end

  defp consume([], acc), do: Enum.empty?(acc)

  defp consume([grapheme | graphemes], []) do
    cond do
      grapheme in @openings ->
        consume(graphemes, [grapheme])

      grapheme in @closings ->
        # mismatch
        false

      true ->
        consume(graphemes, [])
    end
  end

  defp consume([grapheme | graphemes], [bracket | tail] = acc) do
    cond do
      grapheme in @openings ->
        consume(graphemes, [grapheme | acc])

      grapheme in @closings && Map.get(@pairs, grapheme) == bracket ->
        consume(graphemes, tail)

      grapheme in @closings ->
        # mismatch
        false

      true ->
        consume(graphemes, acc)
    end
  end
end
