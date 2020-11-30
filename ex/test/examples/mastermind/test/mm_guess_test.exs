defmodule MM.GuessTest do
  use ExUnit.Case, async: true

  import Corals

  test "pick the first guess from the best choices" do
    %{guess: guess, choices: {best, _, _, _}} = resolve(%{}, MM.Guess)

    assert 2 == length(Enum.uniq guess)
    assert 2 == Enum.count(guess, &(&1 == Enum.at guess, 0))
    refute Enum.member? best, guess
  end

end