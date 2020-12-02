defmodule GoL do

  import Corals
  import Enum, only: [with_index: 1, map: 2, filter: 2]

  define __MODULE__, %{
    rules: [

      _@coords: fn i, size -> [div(i, size), rem(i, size)] end,
      _@index: fn [x, y], size -> x * size + y end,

      _@neighbors: fn [x, y], size ->
        [[-1, -1], [0, -1], [1, -1],
         [-1,  0],          [1,  0],
         [-1,  1], [0,  1], [1,  1]]
        |> map(fn [x1, y1] -> [x + x1, y + y1] end)
        |> filter(fn [x, y] -> x >= 0 && y >= 0 && x < size && y < size end)
      end,

      cells: fn %{cells: cells, _@neighbors: nb, _@coords: c, _@index: i} ->
        size = cells |> length |> :math.sqrt |> round
        cells
        |> with_index
        |> map(fn {x, i} -> {x, c.(i, size) } end)
        |> map(fn {x, c} -> {x, nb.(c, size)} end)
        |> map(fn {x, nbs} -> {x, nbs |> map(&(i.(&1, size)))}end)
        |> map(fn {x, nbs} -> {x, nbs |> map(&(Enum.at cells, &1))}end)
        |> map(fn {x, nbs} -> {x, nbs |> Enum.sum} end)
        |> map(fn
          {1, nb} when nb < 2 -> 0
          {1, nb} when nb == 2 or nb == 3 -> 1
          {_, _} -> 0
        end)
      end

    ]
  }

end