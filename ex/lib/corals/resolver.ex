defmodule Corals.Resolver do

  import Corals.Expander
  import Enum, only: [map: 2, reduce: 2, reduce: 3, into: 2]
  import Map, only: [merge: 2]

  def resolve rules do if is_single? rules do single rules else many rules end end

  defp many rules do rules |> map(&(single &1)) |> reduce(&(merge &2, &1)) end

  defp is_single? rules do Keyword.keyword? rules end

  defp single rules do rules |> reduce(%{}, &(expand &1, &2)) |> into(%{}) end

end