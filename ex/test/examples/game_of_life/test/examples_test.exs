defmodule GoL.Examples do
  use ExUnit.Case

  test "glider" do
    GoL.evolve %{cells: :glider, times: 16, size: [80, 25]}
  end

  test "gosper_gun" do
    GoL.evolve %{cells: :gosper_gun, times: 20}
  end

end