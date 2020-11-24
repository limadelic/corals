defmodule Dominoes.Game do

  import Corals

  define :game, %{
    require: [:table, :players, :controller],
  }

end