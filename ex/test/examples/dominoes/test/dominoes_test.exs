defmodule DominoesTest do
  use ExUnit.Case

  import Corals.Helpers

  def count_dominoes dominoes, players do
    Enum.count(dominoes) + Enum.sum(players |> Enum.map(&(Enum.count &1.dominoes)))
  end

  test "play a whole game" do
    %{on: {result, _}, table: %{dominoes: dominoes}, players: players} = Dominoes.play()


    assert result == :winner || result == :tie
    i count_dominoes dominoes, players
#    assert 40 = count_dominoes dominoes, players
  end

end