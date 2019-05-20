defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    number
    |> consume([])
    |> Enum.reverse()
    |> Enum.join()
  end

  defp consume(number, acc) when number >= 1000 do
    consume(number - 1000, ["M"|acc])
  end

  defp consume(number, acc) when number >= 900 do
    consume(number - 900, ["CM"|acc])
  end

  defp consume(number, acc) when number >= 500 do
    consume(number - 500, ["D"|acc])
  end

  defp consume(number, acc) when number >= 400 do
    consume(number -  400, ["CD"|acc])
  end

  defp consume(number, acc) when number >= 100 do
    consume(number - 100, ["C"|acc])
  end

  defp consume(number, acc) when number >= 90 do
    consume(number - 90, ["XC"|acc])
  end

  defp consume(number, acc) when number >= 50 do
    consume(number - 50, ["L"|acc])
  end

  defp consume(number, acc) when number >= 40 do
    consume(number - 40, ["XL"|acc])
  end

  defp consume(number, acc) when number >= 10 do
    consume(number - 10, ["X"|acc])
  end

  defp consume(number, acc) when number >= 9 do
    consume(number - 9, ["IX"|acc])
  end

  defp consume(number, acc) when number >= 5 do
    consume(number - 5, ["V"|acc])
  end

  defp consume(number, acc) when number >= 4 do
    consume(number - 4, ["IV"|acc])
  end
  
  defp consume(number, acc) when number >= 1 do
    [String.duplicate("I", number)|acc]
  end

  defp consume(_, acc), do: acc
end
