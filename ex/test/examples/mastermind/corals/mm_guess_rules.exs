defmodule MM.Guess do

  import Corals

  import Enum, only: [random: 1]
  import List, only: [delete: 2]

  define __MODULE__, %{
    require: [MM.Score, MM.Choices],
    rules: [
      [ when!: is?(%{score: [:black, :black, :black, :black]}) ],
      [
        when!: not?(%{choices: {[], _, _, _}}),
        guess: fn %{choices: {best, _, _, _}} -> random best end,
        choices: fn %{guess: guess, choices: {best, better, good, bad}} ->
          {delete(best, guess), better, good, bad}
        end
      ]
    ]
  }

end