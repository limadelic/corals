defmodule GoL.Examples do
  use ExUnit.Case

  test "glider" do
    GoL.evolve :glider, 6
  end

end