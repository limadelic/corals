defmodule Dominoes.Table do

  import Corals
  import Enum, only: [shuffle: 1, take: 2, chunk_every: 2]
  import List, only: [last: 1]

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
          _picked: fn %{dominoes: x} -> x |> chunk_every(10) |> take(4) end,
          dominoes: []
        ]
      ],
      [
        when: is?(%{on: {:play, _, _}}),
        table: [
          heads: fn
            %{dominoes: []} -> []
            %{dominoes: [domino]} -> domino
            %{dominoes: [[head,_]|tail]} -> [head, tail |> last |> last]
          end,
          dominoes: fn %{dominoes: _}, %{on: {_, _, domino}} -> [domino] end,
          heads: fn %{dominoes: dominoes} -> hd(dominoes) end
        ]
      ]
    ]
  }

end