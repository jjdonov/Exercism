defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Enum.filter(fn maybe_multiple -> is_multiple(maybe_multiple, factors) end)
    |> Enum.sum
  end

  def is_multiple(maybe_multiple, factors) when is_list(factors) do
    Enum.any?(factors, fn factor -> is_multiple(maybe_multiple, factor) end)
  end

  def is_multiple(maybe_multiple, factor) do
    rem(maybe_multiple, factor) == 0
  end
end
