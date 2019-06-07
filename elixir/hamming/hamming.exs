defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand1), do: {:ok, 0}
  def hamming_distance(strand1, strand2) when not(length(strand1) === length(strand2)), do: {:error, "Lists must be the same length"}
  def hamming_distance(strand1, strand2) do
    calculate_distance(strand1, strand2)
  end

  defp calculate_distance(strand1, strand2, distance \\ 0)

  defp calculate_distance([first_nucleotide|strand1], [first_nucleotide|stand2], distance) do
   calculate_distance(strand1, stand2, distance) 
  end

  defp calculate_distance([_ | strand1], [_ | strand2], distance) do
    calculate_distance(strand1, strand2, distance + 1)
  end

  defp calculate_distance(_, _, distance), do: {:ok, distance}
end
