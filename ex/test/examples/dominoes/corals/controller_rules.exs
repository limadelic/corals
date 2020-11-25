defmodule Dominoes.Controller do

  import Corals
  import Enum, only: [find: 2, find_index: 2, at: 2, map: 2]

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
        when!: is?(%{on: {:turn, _, _}}),
        on: fn %{on: {_, player, _}, players: players} ->
          {:play, player, find(players, &(&1.name == player)).play}
        end,
        when: is?(%{on: {:play, _, nil}}),
        on: fn %{on: {_, player, _}} -> {:knock, player} end
      ],
      [
        when!: is?(%{on: {:play, _, _}}),
        on: fn %{_next: next, table: %{heads: heads}} -> {:turn, next, heads} end
      ]
    ]
  }
end