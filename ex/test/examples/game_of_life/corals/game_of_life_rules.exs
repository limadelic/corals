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
  def evolve cells, 0 do cells end
  def evolve %{} = cells, times do cells |> evolve |> info |> evolve(times - 1) end
  def evolve cells, times do evolve %{cells: cells}, times end

  def info %{cells: cells} do clear(); map cells, &(p &1); :timer.sleep 200; cells end

end