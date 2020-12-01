defmodule Dominoes do

  import Corals

  def play do play %{} end
  def play %{on: {:winner, _}} = done do done end
  def play %{on: {:tie, _}} = done do done end
  def play game do game |> resolve(__MODULE__) |> play end

  define __MODULE__, %{
    require: [Dominoes.Controller],
  }

end