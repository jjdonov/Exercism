defmodule Phone do
  defstruct area_code: "000", local_number: "0000000"

  defimpl String.Chars do
    def to_string(phone = %Phone{}) do
      phone.area_code <> phone.local_number
    end
  end

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    parse(raw)
    |> to_string()
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    %{:area_code => area_code} = parse(raw)
    area_code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) when is_binary(raw) do
    parse(raw)
    |> pretty()
  end

  def pretty(%Phone{:area_code => area_code, :local_number => local_number}) do
    {prefix, line_number} = String.split_at(local_number, 3)
    "(#{area_code}) #{prefix}-#{line_number}"
  end

  defp parse(raw) do
    case String.match?(raw, ~r/[^0-9\s\(\)\.\-\+]/) do
      true ->
        %Phone{}

      false ->
        clean_number(raw)
        |> normalize()
    end
  end

  defp clean_number(raw), do: String.replace(raw, ~r/[\s\(\)\.-]/, "")

  defp normalize("+1" <> number) when byte_size(number) == 10, do: parse(number)
  defp normalize("1" <> number) when byte_size(number) == 10, do: parse(number)

  defp normalize(number) when byte_size(number) == 10 do
    case {String.at(number, 0), String.at(number, 3)} do
      {"0", _} ->
        %Phone{}

      {"1", _} ->
        %Phone{}

      {_, "0"} ->
        %Phone{}

      {_, "1"} ->
        %Phone{}

      _ ->
        {area_code, local_number} = String.split_at(number, 3)
        %Phone{area_code: area_code, local_number: local_number}
    end
  end

  defp normalize(_), do: %Phone{}
end
