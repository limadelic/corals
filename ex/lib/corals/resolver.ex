defmodule Corals.Resolver do

  import Corals.{Expander, Utils, Helpers}
  import Enum, only: [all?: 2, reduce_while: 3, map: 2, zip: 2]

  def resolve rules, opts \\ %{} do
    rules |> resolve_raw(opts, opts) |> clean
  end

  def resolve_raw rules, context, opts, globals \\ nil do
    cond do
      is_list? rules, context -> list rules, context, opts, globals
      is_single? rules -> single rules, context, opts, globals
      are_many? rules -> many rules, context, opts, globals
      opts != %{} -> opts
      true -> rules
    end
  end

  defp are_rules? rules do is_list(rules) && (is_single?(rules) || are_many?(rules)) end
  defp is_list? rules, context do is_single?(rules) && is_map_list?(context) end
  defp is_single? rules do rules != [] && Keyword.keyword?(rules) end
  defp are_many? rules do all? rules, &(are_rules? &1) end

  defp many rules, context, opts, nil do
    reduce_while rules, context, &(cont_many? merge &2, resolve_raw(&1, &2, opts, &2))
  end
  defp many rules, context, opts, globals do
    reduce_while rules, context, &(cont_many? merge &2, resolve_raw(&1, &2, opts, globals))
  end

  defp single rules, context, opts, nil do
    reduce_while rules, context, &(cont_single? merge &2, expand(&1, &2, opts, context))
  end
  defp single rules, context, opts, globals do
    reduce_while rules, context, &(cont_single? merge &2, expand(&1, &2, opts, globals))
  end

  defp list(rules, context, opts, globals) when is_list(opts) and (length(context) == length(opts)) do
    zip(context, opts) |> map(&(resolve_raw rules, elem(&1,0), elem(&1,1), globals))
  end
  defp list rules, context, _, globals do
    context |> map(&(resolve_raw rules, &1, %{}, globals))
  end

end