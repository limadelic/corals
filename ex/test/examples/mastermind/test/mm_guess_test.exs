defmodule MMGuessTest do
  use ExUnit.Case, async: true

  import Corals
  import Corals.Helpers

  describe "choices" do

    setup do resolve %{}, :mm_guess end

    test "there r 1296", %{choices: choices} do
      assert choices |> Tuple.to_list |> Enum.map(&Enum.count/1) |> Enum.sum == 1296
    end

    test "they best choices have 2x2 colors", %{choices: {best, _, _, _}} do
      assert Enum.all? best, fn choice ->
        2 == length(Enum.uniq choice) &&
        2 == Enum.count(choice, &(&1 == Enum.at choice, 0))
      end
    end

  end

  @tag :wip
  test "start with any 2x2 colors", %{guess: guess} do
    assert length Enum.uniq guess == 2
    assert Enum.count guess, guess[0] == 2
  end

end