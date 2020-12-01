defmodule MMTest do
  use ExUnit.Case

  import Corals.Helpers

  test "guess in less than 5" do
    %{guesses: guesses, solution: solution} = MM.play()

    p "\n\n:: Mastermind ::\n"
    i :solution, solution
    i :guesses, guesses

    assert length(guesses) <= 7
  end

end