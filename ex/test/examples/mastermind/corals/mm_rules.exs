defmodule MM do

  import Corals
  import Corals.Helpers

  import Enum, only: [random: 1]

  define __MODULE__, %{
    require: [MM.Guess],
    rules: [
      [
        when: not?(%{solution: _}),
        solution: fn %{choices: {x1, x2, x3, x4}} -> random x1 ++ x2 ++ x3 ++ x4 end
      ],
      [
        when!: not?(%{guesses: _}),
        guesses: fn %{guess: guess} -> [guess] end
      ],
      [
        when: not?(%{solved: true}),
        guesses: fn %{guesses: guesses, guess: guess} -> guesses ++ [guess] end
      ]
    ]
  }

  def play do play %{} end
  def play %{solved: true} = done do info done end
  def play %{} = game do play resolve game, __MODULE__ end
  def play solution do play %{solution: solution} end

  defp info %{guesses: guesses, solution: solution} = game do
    p "\n\n:: Mastermind ::\n"
    i :solution, solution
    i :guesses, guesses
    game
  end

end