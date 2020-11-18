defmodule Corals.Resolver do

  import Corals.{Expander, Utils, Helpers}
  import Enum, only: [all?: 2, reduce_while: 3]

  def resolve rules, opts \\ %{} do
    rules |> resolve_raw(opts, opts) |> clean
  end

  def resolve_raw rules, context, opts, globals \\ nil do
    cond do
      is_single? rules -> single rules, context, opts, globals
      are_many? rules -> many rules, context, opts, globals
      opts != %{} -> opts
      true -> rules
    end
  end

  def are_rules? rules do is_list(rules) && (is_single?(rules) || are_many?(rules)) end
  def is_single? rules do Keyword.keyword? rules end
  def are_many? rules do all? rules, &(are_rules? &1) end

  defp many(rules, context, opts, globals) when is_nil(globals) do
    reduce_while rules, context, &(cont_many? merge &2, resolve_raw(&1, &2, opts, &2))
  end
  defp many rules, context, opts, globals do
    reduce_while rules, context, &(cont_many? merge &2, resolve_raw(&1, &2, opts, globals))
  end

  defp single(rules, context, opts, globals) when is_nil(globals) do
    reduce_while rules, context, &(cont_single? merge &2, expand(&1, &2, opts, context))
  end
  defp single rules, context, opts, globals do
    reduce_while rules, context, &(cont_single? merge &2, expand(&1, &2, opts, globals))
  end

end