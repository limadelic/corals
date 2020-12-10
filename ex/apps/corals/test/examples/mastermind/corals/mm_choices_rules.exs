defmodule MM.Choices do

  import Corals
  import Enum, only: [reduce: 3, uniq: 1, count: 2, at: 2, map: 2, reject: 2]
  import Tuple, only: [to_list: 1]
  import List, only: [to_tuple: 1]

  @colors [:red, :yellow, :green, :blue, :purple, :pink]

  define __MODULE__, %{
    require: [MM.Score],
    rules: [
      [
        when: not?(%{choices: _}),
        choices: (
          for x1 <- @colors, x2 <- @colors, x3 <- @colors, x4 <- @colors,
            do: [x1, x2, x3, x4]
        ),
        choices: fn %{choices: choices} -> reduce choices, {[],[],[],[]},
          fn choice, {best, better, good, bad} ->
            count = length uniq choice
            cond do
              count == 1 -> {best, better, good, [choice | bad]}
              count == 4 -> {best, better, [choice | good], bad}
              count == 3 -> {best, [choice | better], good, bad}
              count(choice, &(&1 == at(choice, 0))) == 2 ->
                {[choice | best], better, good, bad}
              true -> {best, better, good, [choice | bad]}
            end
          end
        end
      ],
      [
        when: is?(%{guess: _}),
        choices: fn %{guess: guess, score: score, choices: choices} ->

          narrow = fn
            ^guess -> true
            choice -> score != resolve(%{guess: choice, solution: guess}, MM.Score).score
          end

          choices |> to_list |> map(fn x -> reject x, &(narrow.(&1)) end) |> to_tuple

        end
      ]
    ]
  }

end