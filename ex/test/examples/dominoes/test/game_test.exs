defmodule StartTest do
  use ExUnit.Case

  import Corals
  import Corals.Helpers

  describe "start" do

    setup do
      i resolve :game, %{on: :start}
    end

    test "wat", _ do
    end

    @tag :wip
    test "empty table", %{table: table} do
      assert table == []
    end

    @tag :wip
    test "4 players", %{players: players} do
      assert length(Map.keys(players)) == 4
    end

    @tag :wip
    test "there r 55 dominoes available", %{dominoes: dominoes} do
      assert length(dominoes) == 55
    end

  end

  @tag :wip
  describe "pick" do

    setup do
      resolve :game, %{on: :start}
    end

    test "each player has 10 dominoes" do
      assert 42 == 10
    end

  end

end