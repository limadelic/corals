defmodule StartTest do
  use ExUnit.Case

  import Corals
  import Corals.Helpers

  describe "start" do

    setup do
      %{on: :start} |> resolve(:game)
    end

    test "55 dominoes available on table", %{table: %{dominoes: dominoes}} do
      assert length(dominoes) == 55
    end

    test "4 players", %{players: players} do
      assert length(players) == 4
    end

  end

  describe "pick" do

    setup do
      %{on: :start}
      |> resolve(:game)
      |> merge(%{on: :pick})
      |> resolve(:game)
    end

    test "each player has 10 dominoes", %{players: players} do
      assert Enum.all?(players, &(length(&1.dominoes) == 10)) == true
    end

    test "there are 15 dominoes left on the table", %{table: %{dominoes: dominoes}} do
      assert length(dominoes) == 15
    end

  end

end