defmodule Dominoes.Controller do

  import Corals
  import Enum, only: [find: 2]

  define :controller, %{
    require: [:players],
    rules: [
      [
        when: is?(%{on: :start}),
        on: :pick
      ],
      [
        when: is?(%{on: {:turn, _, _}}),
        on: fn %{on: {_, player, _}, players: players} ->
          {:play, player, find(players, &(&1.name == player)).play}
        end
      ]
    ]
  }
end