defmodule PlayDominoesTest do
  use ExUnit.Case

  import Corals.Helpers

  test "play a whole game" do
    {result, _} = i Dominoes.play()
    assert result == :winner || result == :tie
  end

end