defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    case parse(isbn) do
      {digits, check_digit} ->
        checksum(digits, check_digit)

      :error ->
        false
    end
  end

  defp parse(string) when byte_size(string) == 13 do
    String.replace(string, "-", "") |> parse()
  end

  defp parse(string) when byte_size(string) == 10 do
    [digits, [check_digit]] = String.graphemes(string) |> Enum.chunk_every(9)

    case {to_integer(digits), convert_check_digit(check_digit)} do
      {:error, _} ->
        :error

      {_, :error} ->
        :error

      {digits, check_digit} ->
        {digits, check_digit}
    end
  end

  defp parse(_), do: :error

  defp convert_check_digit("X"), do: 10
  defp convert_check_digit(digit), do: to_integer(digit)

  defp to_integer(grapheme, acc \\ [])

  defp to_integer(grapheme, _) when is_binary(grapheme) do
    case Integer.parse(grapheme) do
      {integer, ""} ->
        integer

      _ ->
        :error
    end
  end

  defp to_integer([grapheme | graphemes], acc) do
    case to_integer(grapheme) do
      :error ->
        :error

      integer ->
        to_integer(graphemes, [integer | acc])
    end
  end

  defp to_integer([], acc), do: Enum.reverse(acc)

  defp checksum(digits, check_digit) do
    sum =
      [{check_digit, 1} | Enum.zip(digits, 10..2)]
      |> Enum.reduce(0, fn {digit, multiplier}, acc ->
        acc + digit * multiplier
      end)

    rem(sum, 11) === 0
  end
end
