defmodule MM.Guess do

  import Corals
  import Enum, only: [random: 1]

  @colors [:red, :yellow, :green, :blue, :purple, :pink]

  define :mm_guess, %{
    rules: [
      [
        when: not?(%{choices: _}),
        choices: (
          for x1 <- @colors, x2 <- @colors, x3 <- @colors, x4 <- @colors,
            do: [x1, x2, x3, x4]
        )
      ],
#      [
#        when: not?(%{choices: _}),
#        guess: fn %{choices: {best, _, _, _}} -> end
#      ]
    ]
  }

end