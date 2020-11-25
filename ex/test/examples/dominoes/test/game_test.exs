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

  describe "turn on empty table" do

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

    test "the domino is no longer in the players dominoes", %{players: players} do
      assert Enum.at(players, 0).dominoes == []
    end

  end

  describe "turn with dominoes on the table" do

    setup do
      %{
        on: {:turn, :player, [9,9]},
        players: [
          %{name: :player, dominoes: [[0,0],[9,8],[7,7]]},
        ]
      } |> resolve(:game)
    end

    test "the player find a domino to play", %{on: {:play, :player, domino}} do
      assert domino == [9,8]
    end

    test "the domino is no longer in the players dominoes", %{players: players} do
      assert Enum.at(players, 0).dominoes == [[0,0],[7,7]]
    end

  end

  describe "knock if nothing to play" do

    setup do
      %{
        on: {:turn, :player, [9,9]},
        players: [
          %{name: :player, dominoes: [[0,0],[7,7]]},
        ]
      } |> resolve(:game)
    end

    test "the player find a domino to play", %{on: on} do
      assert on == {:knock, :player}
    end

    test "the player has the same dominoes", %{players: players} do
      assert Enum.at(players, 0).dominoes == [[0,0],[7,7]]
    end

  end

  describe "play on empty table" do

    setup do
      %{
        on: {:play, :player, [9,9]},
        table: %{dominoes: []},
        players: [
          %{name: :player},
          %{name: :next}
        ]
      } |> resolve(:game)
    end

    test "the domino goes on then table", %{table: table} do
      assert table.dominoes == [[9,9]]
    end

    test "the table's head is the domino", %{table: table} do
      assert table.heads == [9,9]
    end

    test "it's next player's turn", %{on: on} do
      assert on == {:turn, :next, [9,9]}
    end

  end

  describe "play with 1 domino on the table" do

    setup do
      %{
        on: {:play, :player, [9,8]},
        table: %{dominoes: [[9,9]]},
        players: [
          %{name: :player},
          %{name: :next}
        ]
      } |> resolve(:game)
    end

    test "the domino goes on then table", %{table: table} do
      assert table.dominoes == [[8,9],[9,9]]
    end

    test "the table's head is the head's head n' tail's tail", %{table: table} do
      assert table.heads == [8,9]
    end

  end

  describe "placing dominoes on the table" do

    setup do
      dominoes = [[9,9],[9,8],[8,8],[7,9],[7,7],[8,7],[6,7],[6,6],[9,6],[5,7]]
      game = %{
        on: {},
        table: %{dominoes: []}
      }

      Enum.reduce dominoes, game, fn domino, game ->
        %{game | on: {:play, :player, domino}} |> resolve(:table)
      end
    end

    test "dominoes are placed correctly", %{table: %{dominoes: dominoes}} do
      assert dominoes ==
        [[9,6],[6,6],[6,7],[7,8],[8,8],[8,9],[9,9],[9,7],[7,7],[7,5]]
    end

    test "the heads are right", %{table: %{heads: heads}} do
      assert heads == [9,5]
    end

  end

end