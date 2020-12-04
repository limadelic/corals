defmodule GoL.In do

  import Corals
  import Enum, only: [map: 2, find: 2]
  import List, only: [flatten: 1]

  define __MODULE__, %{
    rules: [
      when: is?(%{cells: [head|_]} when is_binary(head)),
      _strings?: true,
      cells: fn %{cells: cells} -> cells |> map(&to_charlist/1) |> flatten end,
      _char: fn %{cells: cells} -> find cells, &(&1 not in ' ') end,
      cells: fn %{cells: cells} -> cells |> map(fn x when x in ' ' -> 0; _ -> 1 end) end
    ]
  }

end