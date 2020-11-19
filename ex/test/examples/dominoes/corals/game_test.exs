defmodule Dominoes.Game do

  import Corals

  define :game, %{
    rules: [
      [
        when: has?(%{on: :start}),
        table: []
      ]
    ]
  }

end