defmodule GoL.Out do

  import Corals
  import Enum, only: [map: 2, chunk_every: 2, join: 1]

  define __MODULE__, %{
    require: [GoL.Cells],
    rules: [
      [
        when: is?(%{_strings?: true}),
        cells: fn %{cells: cells, _size: size, _char: char} ->
          cells |> map(fn 0 -> " "; _ -> to_string [char] end) |> chunk_every(size) |> map(&join/1)
        end
      ]
    ]
  }

end