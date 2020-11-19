defmodule Dominoes.Game do

  import Corals
  import Enum, only: [shuffle: 1]

  @dominoes for x <- 0..9, y <- x..9, do: [x,y]

  define :game, %{
    rules: [
      [
        when: is?(%{on: :start}),
        dominoes: shuffle(@dominoes),
        table: [],
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