defmodule GoL do

  import Corals
  import Corals.Helpers
  import IEx.Helpers, only: [clear: 0]
  import Enum, only: [map: 2]

  define __MODULE__, %{
    require: [GoL.Out]
  }

  def evolve %{} = game do resolve game, __MODULE__ end
  def evolve cells do evolve(%{cells: cells}).cells end
  def evolve cells, 0 do cells end
  def evolve %{} = game, times do game |> evolve |> info |> evolve(times - 1) end
  def evolve cells, times do evolve %{cells: cells}, times end

  def info %{cells: cells} = game do clear(); map cells, &(p &1); :timer.sleep 200; game end

end