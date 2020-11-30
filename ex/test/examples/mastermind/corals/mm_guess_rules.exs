defmodule MM.Guess do

  import Corals

  import Enum, only: [random: 1]

  define __MODULE__, %{
    require: [MM.Score, MM.Choices],
    rules: [
      [ when!: is?(%{score: [:black, :black, :black, :black]}) ],
      [
        when!: not?(%{choices: {[], _, _, _}}),
        guess: fn %{choices: {best, _, _, _}} -> random best end,
      ]
    ]
  }

end