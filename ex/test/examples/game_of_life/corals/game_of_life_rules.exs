defmodule GoL do

  import Corals
  import Corals.Helpers
  import IEx.Helpers, only: [clear: 0]
  import Enum, only: [map: 2]

  define __MODULE__, %{
    require: [GoL.Out]
  }

  def evolve %{} = cells do resolve cells, __MODULE__ end
  def evolve cells do evolve(%{cells: cells}).cells end
  def evolve cells, 0 do cells.cells end
  def evolve cells, times do cells |> evolve |> info |> evolve(times - 1) end

  def info cells do clear(); map cells, &(p &1); cells end

end