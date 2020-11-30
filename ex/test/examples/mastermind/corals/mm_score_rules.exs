defmodule MM.Score do

  import Corals
  import Enum, only: [zip: 2, reduce: 3, member?: 2]
  import List, only: [delete: 2]

  define __MODULE__, %{
    rules: [
      [
        score: [],
      ],
      [
        when: is?(%{guess: _, solution: _}),
        score: fn %{guess: guess, solution: solution} ->
          zip(guess, solution) |> reduce({[],[],[]}, fn
            {x, x}, {guess, solution, score} -> {guess, solution, [:black | score]}
            {x, y}, {guess, solution, score} -> {[x | guess], [y | solution], score}
          end)
        end,
        score: fn %{score: {guess, solution, score}} ->
          guess |> reduce({solution, score}, fn guess, {solution, score} ->
            cond do
              member? solution, guess -> {delete(solution, guess), [:white | score]}
              true -> {solution, score}
            end
          end)
        end,
        score: fn %{score: {_, score}} -> score end
      ],
      [
        when: is?(%{score: [:black, :black, :black, :black]}),
        solved: true
      ]
    ]
  }
end