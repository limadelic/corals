defmodule Corals.Resolver do

  import Corals.Expander
  import Enum, only: [all?: 2, reduce: 3]
  import Map, only: [merge: 2]

  def resolve rules do
    cond do
      is_single? rules -> single rules
      are_many? rules -> many rules
      true -> rules
    end
  end

  defp are_rules? rules do
    is_list(rules) && (is_single?(rules) || are_many?(rules))
  end

  defp is_single? rules do Keyword.keyword? rules end

  defp single rules, context \\ %{} do
    reduce rules, context, &(expand &1, &2)
  end

  defp are_many? rules do all? rules, &(are_rules? &1) end

  defp many rules do
    reduce rules, %{}, &(merge &2, single(&1, &2))
  end

end