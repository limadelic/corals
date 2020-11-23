defmodule Dominoes.Table do

  import Corals
  import Enum, only: [shuffle: 1, take: 2, chunk_every: 2]

  @dominoes for x <- 0..9, y <- x..9, do: [x,y]

  define :table, %{
    rules: [
      [
        when: is?(%{on: :start}),
        table: [
          dominoes: shuffle(@dominoes),
        ],
      ],
      [
        when: is?(%{on: :pick}),
        table: [
          picked: fn %{dominoes: x} -> x |> chunk_every(10) |> take(4) end
        ]
      ]
    ]
  }

end