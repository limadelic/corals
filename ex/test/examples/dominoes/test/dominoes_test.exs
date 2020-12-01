defmodule DominoesTest do
  use ExUnit.Case

  import Corals.Helpers

  test "play a whole game" do
    %{on: {result, winner}, table: %{dominoes: dominoes}, players: players} = Dominoes.play()

    p "\n\n:: Dominoes ::\n"
    i result, winner
    i :table, dominoes
    i :players, Enum.map(players, &({&1.name, &1.count, &1.dominoes}))

    assert result == :winner || result == :tie
  end

end