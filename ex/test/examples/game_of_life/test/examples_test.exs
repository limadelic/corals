defmodule GoL.Examples do
  use ExUnit.Case

  @tag :gol
  @tag :glider
  test "glider" do
    GoL.evolve %{cells: :glider, times: 50, size: [80, 25]}
  end

  @tag :gol
  @tag :diamond
  test "diamond" do
    GoL.evolve %{cells: :diamond, times: 25, size: [80, 25]}
  end

  @tag :gosper
  @tag :gol
  test "gosper_gun" do
    GoL.evolve %{cells: :gosper_gun, times: 200, size: [80, 25]}
  end

end