defmodule Dominoes.Game do

  import Corals

  define :game, %{
    require: [:table, :players],
  }

end