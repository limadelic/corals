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
      %{on: :start} |> resolve(:game) |> resolve(:game)
    end

    test "each player has 10 dominoes", %{players: players} do
      assert Enum.all?(players, &(length(&1.dominoes) == 10)) == true
    end

    test "there are no dominoes left on the table", %{table: %{dominoes: dominoes}} do
      assert dominoes == []
    end

  end

  describe "turn" do

    setup do
      %{
        on: {:turn, :player, []},
        players: [
          %{name: :player, dominoes: [[9,9]]},
          %{name: :right, dominoes: [[0,0]]}
        ]
      } |> resolve(:game)
    end

    test "the player plays the first domino", %{on: {:play, :player, domino}} do
      assert domino == [9,9]
    end

    test "the dominoe is no longer in the players dominoes", %{players: players} do
      assert Enum.at(players, 0).dominoes == []
    end

  end

end