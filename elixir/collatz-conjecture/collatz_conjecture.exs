defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when not is_integer(input), do: raise FunctionClauseError
  def calc(input)when input < 1, do: raise FunctionClauseError
  def calc(input) do
    do_calc(input) 
  end

  defp do_calc(input, count \\ 0)

  defp do_calc(1, count), do: count

  defp do_calc(input, count) when rem(input, 2) === 0 do
    do_calc(div(input, 2), count + 1) 
  end
  
  defp do_calc(input, count) do
    do_calc((input * 3) + 1, count + 1)
  end

end
