defmodule Corals.Resolver do

  import Corals.Expander
  import Enum, only: [reduce: 3]
  import Map, only: [merge: 2]

  def resolve rules do if is_single? rules do single rules else many rules end end

  defp is_single? rules do Keyword.keyword? rules end

  defp single rules, context \\ %{} do rules |> reduce(context, &(expand &1, &2)) end

  defp many rules do rules |> reduce(%{}, &(merge &2, single(&1, &2))) end

end