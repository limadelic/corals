defmodule MM.GuessTest do
  use ExUnit.Case, async: true

  import Corals
  import Corals.Helpers

  test "pick the first guess from the best choices" do
    %{guess: guess} = resolve %{}, MM.Guess

    assert 2 == length(Enum.uniq guess)
    assert 2 == Enum.count(guess, &(&1 == Enum.at guess, 0))
  end

  test "stop guessing when a solution is found" do
    solution = [:red, :red, :red, :red]
    %{guess: guess} = resolve %{solution: solution, guess: solution}, MM.Guess

    assert guess == solution
  end

end