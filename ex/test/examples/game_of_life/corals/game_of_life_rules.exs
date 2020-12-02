defmodule GoL do

  import Corals
  import Enum, only: [with_index: 1, map: 2]

  define __MODULE__, %{
    rules: [
      _cells: fn %{cells: cells} ->
        size = cells |> length |> :math.sqrt |> round
        cells |> with_index |> map(fn {st, i}->
          %{st: st, i: i, x: div(i, size), y: rem(i, size)}
        end)
      end
    ]
  }

end