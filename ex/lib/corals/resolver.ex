defmodule Corals.Resolver do

  import Corals.Expander
  import Corals.Utils
  import Enum, only: [all?: 2, reduce_while: 3]
  import Map, only: [drop: 2]

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

  defp single rules, context, opts do
    reduce_while rules, context, &(expand &1, &2, opts)
  end

  defp many rules, context, opts do
    reduce_while rules, context, &(one_of_many(&1, &2, opts))
  end

  defp one_of_many _, %{__halt__: _} = context, _ do {:halt, drop(context, [:__halt__])} end
  defp one_of_many rules, context, opts do {:cont, merge(context, resolve(rules, context, opts))} end

  defp clean result do drop_deep result, ~r/^_/ end

end