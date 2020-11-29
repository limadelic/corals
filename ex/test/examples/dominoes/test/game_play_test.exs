defmodule GamePlayTest do
  use ExUnit.Case

  alias Dominoes.Game, as: Game
  import Corals.Helpers

  test "play a whole game" do
    {result, _} = i Game.play()
    assert result == :winner || result == :tie
  end

end