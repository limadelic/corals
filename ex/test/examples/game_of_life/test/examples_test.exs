defmodule GoL.Examples do
  use ExUnit.Case

  test "glider" do
    GoL.evolve %{cells: :glider, times: 6}
  end

end