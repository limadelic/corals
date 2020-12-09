defmodule DominoesTest do
  use ExUnit.Case

  test "play a whole game" do
    %{on: {result, _}} = Dominoes.play()
    assert result == :winner || result == :tie
  end

end