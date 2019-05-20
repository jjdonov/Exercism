defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @chars Enum.to_list(?A..?Z)

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.upcase
    |> has_all_chars?
  end

  defp has_all_chars?(sentence) do
    @chars -- String.to_charlist(sentence) == []
  end
end
