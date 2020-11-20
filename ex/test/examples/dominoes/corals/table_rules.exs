defmodule Dominoes.Table do

  import Corals
  import Enum, only: [shuffle: 1]

  @dominoes for x <- 0..9, y <- x..9, do: [x,y]

  define :table, %{
    rules: [
      [
        dominoes: shuffle(@dominoes),
        table: [],
      ]
    ]
  }

end