defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    cond do
      non_positive?(a, b, c) ->
        {:error, "all side lengths must be positive"}
      violates_ineq?(a, b, c) ->
        {:error, "side lengths violate triangle inequality"}
      a == b && a == c ->
        {:ok, :equilateral}
      a == b || a == c || b ==c ->
        {:ok, :isosceles}
      true ->
        {:ok, :scalene}
      end 
  end

  defp non_positive?(a, b, c), do: non_positive?([a, b, c])
  defp non_positive?(sides), do: Enum.any?(sides, fn s -> s <= 0 end)

  defp violates_ineq?(a, b, c) when a + b < c, do: true
  defp violates_ineq?(a, b, c) when a + c < b, do: true
  defp violates_ineq?(a, b, c) when b + c < a, do: true
  defp violates_ineq?(_, _, _), do: false
end
