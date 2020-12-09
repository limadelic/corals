defmodule MM.Guess do

  import Corals

  import Enum, only: [find_value: 2, random: 1]
  import Tuple, only: [to_list: 1]

  define __MODULE__, %{
    require: [MM.Score, MM.Choices],
    rules: [
      when: not?(%{solved: true}),
      guess: fn %{choices: x} -> x |> to_list |> find_value(&(&1 != [] && random &1)) end
    ]
  }

end