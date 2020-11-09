defmodule Corals.Resolver do

  import Corals.Expander
  import Corals.Utils
  import Enum, only: [all?: 2, reduce: 3]

  def resolve rules, context \\ %{} do
    cond do
      is_single? rules -> single rules, context
      are_many? rules -> many rules, context
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

  defp many rules, context do
    reduce rules, context, &(merge &2, single(&1, &2))
  end

end