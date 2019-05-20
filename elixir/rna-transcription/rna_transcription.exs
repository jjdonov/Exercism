defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&translate/1)
  end

  defp translate(?G) do ?C end
  defp translate(?C) do ?G end
  defp translate(?T) do ?A end
  defp translate(?A) do ?U end

end
