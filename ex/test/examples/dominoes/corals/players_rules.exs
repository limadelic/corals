defmodule Dominoes.Players do

  import Corals
  import Enum, only: [map: 2, zip: 2]

  @names [:player, :right, :front, :left]

  define :players, %{
    require: [:table],
    rules: [
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
      ]
    ]
  }

end