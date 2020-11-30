defmodule PlayDominoesTest do
  use ExUnit.Case

  import Corals.Helpers

  test "play a whole game" do
    {result, winner} = Dominoes.play()

    p "\nDominoes"
    i result, winner

    assert result == :winner || result == :tie
  end

end