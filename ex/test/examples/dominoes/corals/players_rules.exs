defmodule Dominoes.Players do

  import Corals
  import Enum, only: [map: 2, zip: 2, find: 2, sum: 1]
  import List, only: [first: 1, delete: 2, flatten: 1]

  @names [:player, :right, :front, :left]

  define :players, %{
    require: [:table],
    rules: [
      [
        _@play: fn
          dominoes, [] -> first dominoes
          dominoes, [h,t] -> find dominoes, fn
            [^h, _] -> true
            [_, ^t] -> true
            [_, ^h] -> true
            [^t, _] -> true
            _ -> false
          end
        end
      ],
      [
        when: is?(%{on: :start}),
        players: @names |> map(&(%{name: &1, dominoes: []}))
      ],
      [
        when: is?(%{on: :pick}),
        players: fn %{players: players, table: %{_picked: dominoes}} ->
          players |> zip(dominoes) |> map(fn {player, dominoes} ->
            %{player | dominoes: dominoes}
          end)
        end
      ],
      [
        when: is?(%{on: {:turn, _, _}}),
        players: [
          when: is?(%{name: player},%{on: {_, player, _}}),
          play: fn %{dominoes: x}, %{_@play: play, on: {_, _, heads}} -> x |> play.(heads) end,
          dominoes: fn %{dominoes: dominoes, play: domino} -> delete dominoes, domino end
        ]
      ],
      [
        when: is?(%{on: :stuck}),
        players: [
          count: fn %{dominoes: dominoes} -> dominoes |> flatten |> sum end
        ]
      ],
      [
        when: is?(%{on: {:dominate, _, _}}),
        players: [
          count: fn %{dominoes: dominoes} -> dominoes |> flatten |> sum end
        ]
      ]
    ]
  }

end