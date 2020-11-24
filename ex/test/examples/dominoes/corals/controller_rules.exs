defmodule Dominoes.Controller do

  import Corals

  define :controller, %{
    require: [:players],
    rules: [
      [
        when: is?(%{on: :start}),
        on: :pick
      ]
    ]
  }
end