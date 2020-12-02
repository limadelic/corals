defmodule GoL do

  import Corals
  import Enum, only: [with_index: 1, map: 2, filter: 2, at: 2, sum: 1]

  def evolve cells do evolve cells, 1 end
  def evolve cells, 0 do cells.cells end
  def evolve cells, times do
    %{cells: cells} |> resolve(__MODULE__) |> evolve(times - 1)
  end

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

      _@evolve: fn
        {1, neighbors} when neighbors < 2 -> 0
        {1, neighbors} when neighbors == 2 or neighbors == 3 -> 1
        {1, neighbors} when neighbors > 3 -> 0
        {0, neighbors} when neighbors == 3 -> 1
        {0, _} -> 0
      end,

      cells: fn %{cells: cells, _neighbors: neighbors, _@find: find, _@count: count, _@evolve: evolve} ->
        with_index(cells)
        |> map(fn {cell, index} -> {cell, find.(neighbors, cells, index)} end)
        |> map(fn {cell, neighbors} -> {cell, count.(neighbors, cells)} end)
        |> map(&(evolve.(&1)))
      end

    ]
  }

end