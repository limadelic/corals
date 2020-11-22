defmodule Dominoes.Players do

  import Corals
  import Enum, only: [take: 2]

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
        players: [
          dominoes: fn _, %{table: %{dominoes: dominoes}} ->
            take dominoes, 10
          end
        ]
      ]
    ]
  }

end