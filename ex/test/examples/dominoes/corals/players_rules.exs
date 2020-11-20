defmodule Dominoes.Players do

  import Corals

  define :players, %{
    rules: [
      [
        when: is?(%{on: :start}),
        players: [
          player: [],
          right: [],
          front: [],
          left: [],
        ]
      ]
    ]
  }

end