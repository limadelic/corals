defmodule StartTest do
  use ExUnit.Case

  import Corals

  describe "start" do

    setup do
      resolve :game, %{on: :start}
    end

    test "empty table", %{table: table} do
      assert table == []
    end

    test "4 players", %{players: players} do
      assert length(players) == 4
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