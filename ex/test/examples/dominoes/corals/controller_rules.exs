defmodule Dominoes.Controller do

  import Corals
  import Enum, only: [find: 2, find_index: 2, at: 2, map: 2, all?: 2, sort_by: 2, take_while: 2]

  define :controller, %{
    require: [:players],
    rules: [
      [
        when!: not?(%{on: _}),
        on: :start
      ],
      [
        when!: is?(%{on: :start}),
        on: :pick
      ],
      [
        when: either?([
          is?(%{on: :pick}),
          is?(%{on: {:knock, _, _}}),
          is?(%{on: {:play, _, _}})
        ]),
        _next: fn %{players: players, on: on} ->
          names = map players, &(&1.name)
          order = names ++ [hd(names)]
          case on do
            {_, player, _} -> at order, find_index(order, &(&1 == player)) + 1
            _ -> hd order
          end
        end,
      ],
      [
        when!: is?(%{on: :pick}),
        on: fn %{_next: next} -> {:turn, next, []} end
      ],
      [
        when!: is?(%{on: {:turn, _, _}}),
        _player: fn %{on: {_, x, _}, players: players} -> find players, &(&1.name == x) end,
        on: fn
          %{_player: %{name: name, play: domino, dominoes: []}} -> {:dominate, name, domino}
          %{_player: %{name: name, play: domino}} -> {:play, name, domino}
        end,
        when: is?(%{on: {:play, _, nil}}),
        on: fn %{on: {_, player, _}, table: %{heads: heads}} -> {:knock, player, heads} end
      ],
      [
        when!: is?(%{on: {:knock, _, _}}),
        _stuck?: fn %{players: players} -> all? players, &(&1[:play] == nil) end,
        on: fn
          %{_stuck?: true} -> :stuck
          %{_next: next, table: %{heads: heads}} -> {:turn, next, heads}
        end
      ],
      [
        when!: is?(%{on: {:play, _, _}}),
        on: fn %{_next: next, table: %{heads: heads}} -> {:turn, next, heads} end
      ],
      [
        when!: is?(%{on: {:dominate, _, _}}),
        on: fn %{on: {_, player, _}} -> {:winner, player} end
      ],
      [
        when!: is?(%{on: :stuck}),
        _winners: fn %{players: players} ->
          sorted = sort_by players, &(&1.count)
          score = at(sorted, 0).count
          sorted |> take_while(&(&1.count == score)) |> map(&(&1.name))
        end,
        on: fn
          %{_winners: [winner]} -> {:winner, winner}
          %{_winners: winners} -> {:tie, winners}
        end
      ]
    ]
  }
end