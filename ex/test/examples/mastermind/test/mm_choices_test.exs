defmodule MM.ChoicesTest do
  use ExUnit.Case, async: true

  import Corals

  describe "choices" do

    setup do resolve %{}, MM.Choices end

    test "there r 1296", %{choices: choices} do
      assert 1296 == choices |> Tuple.to_list |> Enum.map(&Enum.count/1) |> Enum.sum
    end

    test "the best choices have 2x2 colors", %{choices: {best, _, _, _}} do
      assert Enum.all? best, fn choice ->
        2 == length(Enum.uniq choice) &&
        2 == Enum.count(choice, &(&1 == Enum.at choice, 0))
      end
    end

    test "the better choices have 2X1X1 colors", %{choices: {_, better, _, _}} do
      assert Enum.all? better, fn choice ->
        3 == length Enum.uniq choice
      end
    end

    test "the good choices have 1X1X1X1 colors", %{choices: {_, _, good, _}} do
      assert Enum.all? good, fn choice ->
        4 == length Enum.uniq choice
      end
    end

    test "the bad choices are either 4 or 3 of the same color", %{choices: {_, _, _, bad}} do
      assert Enum.all? bad, fn choice ->
        1 == length(Enum.uniq choice) ||
        3 == Enum.count(choice, &(&1 == Enum.at choice, 0)) ||
        3 == Enum.count(choice, &(&1 == Enum.at choice, 1))
      end
    end

  end

end