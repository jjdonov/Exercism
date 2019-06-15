defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2

  def nth(n) when n > 1 do
    find_nth(n, 3, [2])
  end

  defp find_nth(n, num, primes = [latest | _]) when length(primes) == n do
    latest
  end

  defp find_nth(n, num, primes) do
    next_num = num + 2
    if is_indivisible(num, primes) do
      find_nth(n, next_num, [num | primes])
    else
      find_nth(n, next_num, primes)
    end
  end

  defp is_indivisible(dividend, divisors) do
    Enum.all?(divisors, fn divisor ->
      rem(dividend, divisor) != 0
    end)
  end
end
