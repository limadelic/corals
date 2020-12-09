defmodule GoL.Out do

  import Corals
  import Enum, only: [map: 2, chunk_every: 2, join: 1]

  define __MODULE__, %{
    require: [GoL.Cells],
    rules: [
      [
        cells: fn %{cells: cells, size: [width, _], _char: char} ->
          cells |> map(fn 0 -> " "; _ -> to_string [char] end) |> chunk_every(width) |> map(&join/1)
        end
      ],
      [
        when: is?(%{times: _}),
        times: fn %{times: times} -> times - 1 end
      ]
    ]
  }

end