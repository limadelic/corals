defmodule MMGuessTest do
  use ExUnit.Case, async: true

  import Corals

  @solution [:red, :green, :blue, :yellow]

  setup do
    %{solution: @solution} |> resolve(:mm_guess)
  end

  test "there r 1296 choices", %{choices: choices}do
    assert length(choices) == 1296
  end

  @tag :wip
  test "start with any 2x2 colors", %{guess: guess} do
    assert length Enum.uniq guess == 2
    assert Enum.count guess, guess[0] == 2
  end

end