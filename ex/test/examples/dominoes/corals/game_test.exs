defmodule Dominoes.Game do

  import Corals

  define :game, %{
    rules: [
      [
        when: is?(%{on: :start}),
        table: []
      ]
    ]
  }

end