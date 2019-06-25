defmodule Tournament do
  @default_results %{matches_played: 0, points: 0, wins: 0, losses: 0, draws: 0}

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    parse_input(input)
    |> tally_games()
    |> Map.to_list()
    |> Enum.sort(&comparator/2)
    |> table_format()
  end

  def parse_input(input) do
    Enum.flat_map(input, &parse_line/1)
  end

  def parse_line(line) do
    case String.split(line, ";") do
      [first_team, second_team, result] ->
        parse_outcome(first_team, second_team, result)
      _ ->
        []
    end
  end

  def parse_outcome(first_team, second_team, result) do
    case opposite_outcome(result) do
      {:ok, opposite} -> 
        [{first_team, result}, {second_team, opposite}]
      :error ->
        []
    end
  end

  def opposite_outcome("win"), do:  {:ok, "loss"}
  def opposite_outcome("loss"), do: {:ok, "win"}
  def opposite_outcome("draw"), do: {:ok, "draw"}
  def opposite_outcome(_), do: :error

  def tally_games(parsed_input) do
    Enum.reduce(parsed_input, %{}, fn {team, result}, acc ->
      acc =
        unless Map.has_key?(acc, team) do
          Map.put(acc, team, @default_results)
        else
          acc
        end

      Map.update!(acc, team, fn results ->
        update_results(results, result)
      end)
    end)
  end

  def update_results(
        results = %{matches_played: matches_played, wins: wins, points: points},
        "win"
      ) do
    %{results | matches_played: matches_played + 1, points: points + 3, wins: wins + 1}
  end

  def update_results(results = %{matches_played: matches_played, losses: losses}, "loss") do
    %{results | matches_played: matches_played + 1, losses: losses + 1}
  end

  def update_results(
        results = %{matches_played: matches_played, draws: draws, points: points},
        "draw"
      ) do
    %{results | matches_played: matches_played + 1, draws: draws + 1, points: points + 1}
  end

  def comparator({first_name, %{points: points}}, {second_name, %{points: points}}) do
    first_name <= second_name
  end

  def comparator({_, %{points: first_points}}, {_, %{points: second_points}}) do
    first_points > second_points
  end

  @header_format "~-31s| ~2s | ~2s | ~2s | ~2s | ~2s"
  @format "~-31s| ~2b | ~2b | ~2b | ~2b | ~2b"

  def table_format(results) do
    header = :io_lib.format(@header_format, ["Team", "MP", "W", "D", "L", "P"]) |> to_string()

    rows =
      Enum.map(results, fn {team_name, records} ->
        %{
          matches_played: matches_played,
          wins: wins,
          draws: draws,
          losses: losses,
          points: points
        } = records

        :io_lib.format(@format, [team_name, matches_played, wins, draws, losses, points])
        |> to_string()
      end)

    Enum.join([header | rows], "\n")
  end
end
