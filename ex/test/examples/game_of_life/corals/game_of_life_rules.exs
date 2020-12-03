defmodule GoL do

  import Corals

  define __MODULE__, %{
    require: [GoL.Cells]
  }

  def evolve cells do evolve cells, 1 end
  def evolve cells, 0 do cells.cells end
  def evolve cells, times do %{cells: cells} |> resolve(__MODULE__) |> evolve(times - 1) end

end