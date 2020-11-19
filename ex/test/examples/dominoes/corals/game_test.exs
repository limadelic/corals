defmodule Dominoes.Game do

  import Corals

  define :game, %{
    rules: [
      [
        when: [on: :start],
        table: []
      ]
    ]
  }

end