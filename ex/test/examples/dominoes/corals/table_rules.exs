defmodule Dominoes.Table do

  import Corals
  import Enum, only: [shuffle: 1, take: 2, chunk_every: 2]
  import List, only: [last: 1]

  @dominoes for x <- 0..9, y <- x..9, do: [x,y]

  define :table, %{
    rules: [
      [
        table: [

          _@heads: fn
            [] -> []
            [domino] -> domino
            [[head,_]|tail] -> [head, tail |> last |> last]
          end,

          _@place: fn
            [], _heads, domino -> [domino]
            dominoes, [h,_], [h,t] -> [[t,h] | dominoes]
            dominoes, [h,_], [t,h] -> [[t,h] | dominoes]
            dominoes, [_,t], [t,h] -> dominoes ++ [[t,h]]
            dominoes, [_,t], [h,t] -> dominoes ++ [[t,h]]
            dominoes, _heads, _domino -> dominoes
          end

        ]
      ],
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
          heads: fn %{_@heads: heads, dominoes: dominoes} -> heads.(dominoes) end,
          dominoes: fn %{_@place: place, dominoes: dominoes, heads: heads}, %{on: {_,_,domino}} ->
            place.(dominoes, heads, domino)
          end
        ]
      ],
      [
        when: is?(%{on: {:dominate, _, _}}),
        table: [
          heads: fn %{_@heads: heads, dominoes: dominoes} -> heads.(dominoes) end,
          dominoes: fn %{_@place: place, dominoes: dominoes, heads: heads}, %{on: {_,_,domino}} ->
            place.(dominoes, heads, domino)
          end
        ]
      ],
      [
        table: [
          heads: fn
            %{_@heads: heads, dominoes: dominoes} -> heads.(dominoes)
            _ -> []
          end
        ]
      ]
    ]
  }

end