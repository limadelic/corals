defmodule Dominoes.Controller do

  import Corals
  import Enum, only: [find: 2, find_index: 2, at: 2, map: 2, all?: 2, sort_by: 2]

  define :controller, %{
    require: [:players],
    rules: [
      [
        _names: fn %{players: players} -> map players, &(&1.name) end,
        _order: fn %{_names: names} -> names ++ [hd(names)] end,
        _next: fn
          %{_order: order, on: {_, player, _}} ->
            at order, find_index(order, &(&1 == player)) + 1
          %{_order: order} -> hd order
        end
      ],
      [
        when!: is?(%{on: :start}),
        on: :pick
      ],
      [
        when!: is?(%{on: :pick}),
        on: fn %{_order: order} -> {:turn, hd(order), []} end
      ],
      [
        when!: is?(%{on: {:turn, _, _}}),
        on: fn %{on: {_, player, _}, players: players} ->
          {:play, player, find(players, &(&1.name == player)).play}
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
        when!: is?(%{on: :stuck}),
        _winner: fn %{players: players} -> players |> sort_by(&(&1.count)) |> at(0) end,
        on: fn %{_winner: winner} -> {:winner, winner.name} end
      ]
    ]
  }
end