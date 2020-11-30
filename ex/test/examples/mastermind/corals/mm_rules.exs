defmodule MM do

  import Corals
  import Enum, only: [random: 1]

  def play do play %{} end
  def play %{score: [:black, :black, :black, :black]} = done do done end
  def play %{} = game do play resolve game, __MODULE__ end
  def play solution do play %{solution: solution} end

  define __MODULE__, %{
    require: [MM.Guess],
    rules: [
      [
        when: not?(%{solution: _}),
        solution: fn %{choices: {x1, x2, x3, x4}} -> random x1 ++ x2 ++ x3 ++ x4 end
      ],
      [
        when!: not?(%{attempts: _}),
        attempts: 0
      ],
      [
        attempts: fn %{attempts: x} -> x + 1 end
      ]
    ]
  }
end