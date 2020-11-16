defmodule Corals.Resolver do

  import Corals.Expander
  import Corals.Utils
  import Corals.Helpers
  import Enum, only: [all?: 2, reduce_while: 3]

  def resolve rules, opts \\ %{} do
    clean resolve rules, opts, opts
  end

  def resolve rules, context, opts do
    cond do
      is_single? rules -> single rules, context, opts
      are_many? rules -> many rules, context, opts
      opts != %{} -> opts
      true -> rules
    end
  end

  defp are_rules? rules do is_list(rules) && (is_single?(rules) || are_many?(rules)) end
  defp is_single? rules do Keyword.keyword? rules end
  defp are_many? rules do all? rules, &(are_rules? &1) end

  defp many rules, context, opts do
    reduce_while rules, context, &(cont_many? merge &2, resolve(&1, &2, opts))
  end

  defp single rules, context, opts do
    reduce_while rules, context, &(cont_single? merge &2, expand(&1, &2, opts))
  end

end