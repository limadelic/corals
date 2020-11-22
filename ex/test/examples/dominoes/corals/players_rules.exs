defmodule Dominoes.Players do

  import Corals
  import Enum, only: [take: 2, map: 2]
  import Map, only: [put: 3]

  define :players, %{
    rules: [
      [
        when: is?(%{on: :start}),
        players: [
          %{name: :player},
          %{name: :right},
          %{name: :front},
          %{name: :left}
        ]
      ],
      [
        when: is?(%{on: :pick}),
        players: fn _, %{players: players, table: %{dominoes: dominoes}} ->
          map(players, &(put &1, :dominoes, take(dominoes, 10)))
        end
      ]
    ]
  }

end