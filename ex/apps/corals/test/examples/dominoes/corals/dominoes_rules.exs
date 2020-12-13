defmodule Dominoes do

  import Corals
  import Corals.Helpers

  define __MODULE__, %{
    require: [Dominoes.Controller],
  }

  def play do play %{} end
  def play %{on: {:winner, _}} = done do info done end
  def play %{on: {:tie, _}} = done do info done end
  def play game do game |> resolve(__MODULE__)  |> play end

  defp info %{on: {result, winner}, table: %{snake: dominoes}, players: players}= game do
    p "\n\n:: Dominoes ::\n"
    i result, winner
    i :table, dominoes
    i :players, Enum.map(players, &({&1.name, &1.count, &1.dominoes}))
    game
  end

end