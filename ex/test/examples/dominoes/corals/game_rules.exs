defmodule Dominoes.Game do

  import Corals

  def play do play %{} end
  def play %{on: {:winner, _} = done} do done end
  def play %{on: {:tie, _} = done} do done end
  def play game do game |> resolve(:game) |> play end

  define :game, %{
    require: [:controller],
  }

end