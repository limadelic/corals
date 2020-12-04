defmodule GoL.Cells do

  import Corals
  import Enum, only: [with_index: 1, map: 2]

  define __MODULE__, %{
    require: [GoL.Neighbors, GoL.In],
    rules: [

      _@evolve: fn
        {1, neighbors} when neighbors < 2 -> 0
        {1, neighbors} when neighbors in [2,3] -> 1
        {1, neighbors} when neighbors > 3 -> 0
        {0, neighbors} when neighbors == 3 -> 1
        {0, _} -> 0
      end,

      cells: fn %{cells: cells, _size: size, _neighbors: neighbors, _@find: find, _@count: count, _@evolve: evolve} ->
        with_index(cells)
        |> map(fn {cell, index} -> {cell, find.(neighbors, index, size)} end)
        |> map(fn {cell, neighbors} -> {cell, count.(neighbors, cells)} end)
        |> map(&(evolve.(&1)))
      end

    ]
  }

end