defmodule GoL.Neighbors do

  import Corals
  import Enum, only: [map: 2, filter: 2, at: 2, sum: 1]

  define __MODULE__, %{
    rules: [

      _neighbors: [
        [-1, -1], [0, -1], [1, -1],
        [-1,  0],          [1,  0],
        [-1,  1], [0,  1], [1,  1]
      ],

      _@find: fn neighbors, cells, index ->
         size = cells |> length |> :math.sqrt |> round
        [x, y] = [div(index, size), rem(index, size)]

        neighbors
        |> map(fn [x1, y1] -> [x + x1, y + y1] end)
        |> filter(fn [x, y] -> x >= 0 && y >= 0 && x < size && y < size end)
        |> map(fn [x, y] -> x * size + y end)
      end,

      _@count: fn neighbors, cells -> neighbors |> map(&(at cells, &1)) |> sum end,

    ]
  }

end