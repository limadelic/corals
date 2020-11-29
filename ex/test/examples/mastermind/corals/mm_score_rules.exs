defmodule MMScore do

  import Corals
  import Enum, only: [zip: 2, reduce: 3]

  define :mm_score, %{
    rules: [
      score: fn %{guess: guess, solution: solution} ->
        zip(guess, solution) |> reduce({[],[],[]}, fn
          {x, x}, {guess, solution, score} -> {guess, solution, [:black | score]}
          {x, y}, {guess, solution, score} -> {[x | guess], [y | solution], score}
        end)
      end,
      score: fn %{score: {_, _, score}} -> score end
    ]
  }
end