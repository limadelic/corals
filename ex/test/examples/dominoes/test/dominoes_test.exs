defmodule DominoesTest do
  use ExUnit.Case

  import Corals.Helpers

  def count_dominoes dominoes, players do
    Enum.count(dominoes) + Enum.sum(players |> Enum.map(&(Enum.count &1.dominoes)))
  end

  @tag :wip
  test "play a whole game" do
    %{on: {result, winner}, table: %{dominoes: dominoes}, players: players} = Dominoes.play()

    p "\n\n:: Dominoes ::\n"
    i result, winner
    i :table, dominoes
    i :players, Enum.map(players, &({&1.name, &1.count, &1.dominoes}))

    assert result == :winner || result == :tie
    assert 40 = count_dominoes dominoes, players
  end

end