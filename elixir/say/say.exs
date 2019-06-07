defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number > 999_999_999_999 or number < 0 do
    {:error, "number is out of range"}
  end

  def in_english(0), do: {:ok, "zero"}

  def in_english(number) when number < 100 do
    {:ok, ones_and_tens(number)}
  end

  def in_english(number) when number < 1_000 do
    {hundreds, rest} = {div(number, 100), rem(number, 100)}

    result =
      if rest == 0 do
        "#{ones_and_tens(hundreds)} hundred"
      else
        "#{ones_and_tens(hundreds)} hundred #{ones_and_tens(rest)}"
      end

    {:ok, result}
  end

  def in_english(number) do
    result =
      [
        billions_part(number),
        millions_part(number),
        thousands_part(number),
        less_than_thousands_part(number)
      ]
      |> Enum.filter(fn {count, _} -> count > 0 end)
      |> Enum.map(fn {count, label} ->
        {:ok, english} = in_english(count)
        "#{english}#{label}"
      end)
      |> IO.inspect()
      |> Enum.join(" ")

    {:ok, result}
  end

  defp ones_and_tens(1), do: "one"
  defp ones_and_tens(2), do: "two"
  defp ones_and_tens(3), do: "three"
  defp ones_and_tens(4), do: "four"
  defp ones_and_tens(5), do: "five"
  defp ones_and_tens(6), do: "six"
  defp ones_and_tens(7), do: "seven"
  defp ones_and_tens(8), do: "eight"
  defp ones_and_tens(9), do: "nine"
  defp ones_and_tens(10), do: "ten"
  defp ones_and_tens(11), do: "eleven"
  defp ones_and_tens(12), do: "twelve"
  defp ones_and_tens(13), do: "thirteen"
  defp ones_and_tens(14), do: "fourteen"
  defp ones_and_tens(15), do: "fiftenn"
  defp ones_and_tens(16), do: "sixteen"
  defp ones_and_tens(17), do: "seventeen"
  defp ones_and_tens(18), do: "eighteen"
  defp ones_and_tens(19), do: "nineteen"

  defp ones_and_tens(number) when rem(number, 10) === 0 do
    "#{tens(div(number, 10))}"
  end

  defp ones_and_tens(number) do
    "#{tens(div(number, 10))}-#{ones_and_tens(rem(number, 10))}"
  end

  defp tens(2), do: "twenty"
  defp tens(3), do: "thirty"
  defp tens(4), do: "forty"
  defp tens(5), do: "fifty"
  defp tens(6), do: "sixty"
  defp tens(7), do: "seventy"
  defp tens(8), do: "eighty"
  defp tens(9), do: "ninety"

  defp billions_part(number), do: {div(number, 1_000_000_000), " billion"}
  defp millions_part(number), do: {div(rem(number, 1_000_000_000), 1_000_000), " million"}
  defp thousands_part(number), do: {div(rem(number, 1_000_000), 1_000), " thousand"}
  defp less_than_thousands_part(number), do: {rem(number, 1_000), ""}
end
