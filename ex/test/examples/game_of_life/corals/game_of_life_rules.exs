defmodule GoL do

  import Corals
  import Corals.Helpers
  import IEx.Helpers, only: [clear: 0]
  import Enum, only: [map: 2]

  define __MODULE__, %{
    require: [GoL.Out]
  }

  def evolve %{times: 0} = game do game end
  def evolve %{times: _} = game do game |> do_evolve |> info |> evolve end
  def evolve game do do_evolve game end

  defp do_evolve game do resolve game, __MODULE__ end
  defp info %{cells: cells} = game do clear(); map cells, &(p &1); :timer.sleep 200; game end

end