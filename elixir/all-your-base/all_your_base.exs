defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base, base), do: digits
  def convert(digits, base_a, base_b) when base_a < 2 or base_b < 2, do: nil
  def convert([], _, _), do: nil

  def convert(digits, base_a, base_b) do
    base_ten(digits, base_a)
    |> to_base(base_b)
  end

  defp base_ten(digits, base) do
    size = length(digits)

    Enum.with_index(digits)
    |> Enum.reduce_while(0, fn {digit, index}, acc ->
      if digit < 0 or digit >= base do
        {:halt, nil}
      else
        value = digit * trunc(:math.pow(base, size - index - 1))
        {:cont, acc + value}
      end
    end)
  end

  defp to_base(number, base, acc \\ [])
  defp to_base(nil, _, _), do: nil
  defp to_base(0, _, []), do: [0]
  defp to_base(0, _, acc), do: acc

  defp to_base(number, base, acc) do
    to_base(div(number, base), base, [rem(number, base) | acc])
  end
end
