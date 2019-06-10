defmodule RobotSimulator do
  defstruct direction: nil, position: nil

  @directions [:north, :south, :east, :west]
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, position = {x, y}) when direction in @directions and is_integer(x) and is_integer(y) do
    %RobotSimulator{direction: direction, position: position}
  end

  def create(direction, _) when direction in @directions, do: {:error, "invalid position"}
  def create(_, _), do: {:error, "invalid direction"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) when is_binary(instructions) do
    simulate(robot, String.graphemes(instructions))
  end

  def simulate(robot, []) do
   robot 
  end

  def simulate(robot = %RobotSimulator{direction: direction}, ["L"|instructions]) do
    new_direction = case direction do
      :north ->
        :west
      :west ->
        :south
      :south ->
        :east
      :east ->
        :north
    end

    simulate(%RobotSimulator{robot | direction: new_direction}, instructions)
  end

  def simulate(robot = %RobotSimulator{direction: direction}, ["R"|instructions]) do
    new_direction = case direction do
      :north ->
        :east
      :east ->
        :south
      :south ->
        :west
      :west ->
        :north
    end

    simulate(%RobotSimulator{robot | direction: new_direction}, instructions)
  end

  def simulate(robot = %RobotSimulator{direction: direction, position: {x, y}}, ["A"|instructions]) do
    new_position = case direction do
      :north ->
        {x, y + 1}
      :east ->
        {x + 1, y}
      :south ->
        {x, y - 1}
      :west ->
        {x - 1, y}
    end
    
    simulate(%RobotSimulator{robot | position: new_position}, instructions)
  end

  def simulate(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
