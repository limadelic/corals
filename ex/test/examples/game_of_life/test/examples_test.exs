defmodule GoL.Examples do
  use ExUnit.Case

  test "glider" do
    GoL.evolve %{cells: :glider, times: 6, size: [80, 25]}
  end

end