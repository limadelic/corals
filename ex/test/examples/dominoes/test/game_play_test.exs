defmodule GamePlayTest do
  use ExUnit.Case

  import Corals
  import Corals.Helpers

  defp play do play %{} end
  defp play %{on: {:winner, _} = game} do game end
  defp play %{on: {:tie, _} = game} do game end
  defp play game do game |> resolve(:game) |> play end

  test "play a whole game" do
    {result, _} = i play()
    assert result == :winner || result == :tie
  end

end