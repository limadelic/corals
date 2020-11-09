defmodule Corals.Resolver do

  import Enum, only: [map: 2, reduce: 2, into: 2]
  import Map, only: [merge: 2]

  def resolve rules do if is_single? rules do single rules else many rules end end

  defp is_single? rules do Keyword.keyword? rules end

  defp single rules do rules |> map(&(expand &1)) |> into(%{}) end

  defp many rules do rules |> map(&(single &1)) |> reduce(&(merge &2, &1)) end

  defp expand({k,v}) when is_function(v) do {k, v.()} end
  defp expand x do x end

end