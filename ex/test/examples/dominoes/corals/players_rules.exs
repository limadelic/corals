defmodule Dominoes.Players do

  import Corals

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
        ]
      ]
    ]
  }

end