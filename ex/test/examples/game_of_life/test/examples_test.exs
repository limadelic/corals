defmodule GoL.Examples do
  use ExUnit.Case

  @tag :wip
  test "glider" do
    GoL.evolve :glider, 6
  end

end