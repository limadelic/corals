defmodule Corals.Resolver do

  import Corals.{Expander, Utils, Helpers}
  import Enum, only: [all?: 2, reduce_while: 3, map: 2, zip: 2]

  def resolve rules, user_opts \\ %{} do
    rules |> resolve_raw(user_opts, user_opts) |> clean
  end

  def resolve_raw rules, opts, user_opts, globals \\ nil do
    cond do
      is_list? rules, opts -> list rules, opts, user_opts, globals
      is_single? rules -> single rules, opts, user_opts, globals
      are_many? rules -> many rules, opts, user_opts, globals
      globals == nil -> opts
      user_opts != %{} -> user_opts
      true -> rules
    end
  end

  defp are_rules? [] do false end
  defp are_rules? rules do is_list(rules) && (is_single?(rules) || are_many?(rules)) end
  defp is_list? rules, opts do is_single?(rules) && is_map_list?(opts) end
  defp is_single? [] do false end
  defp is_single? rules do Keyword.keyword?(rules) end
  defp are_many? [] do false end
  defp are_many? rules do all? rules, &(are_rules? &1) end

  defp many rules, opts, user_opts, nil do
    reduce_while rules, opts, &(cont_many? merge &2, resolve_raw(&1, &2, user_opts, &2))
  end
  defp many rules, opts, user_opts, globals do
    reduce_while rules, opts, &(cont_many? merge &2, resolve_raw(&1, &2, user_opts, globals))
  end

  defp single rules, opts, user_opts, nil do
    reduce_while rules, opts, &(cont_single? merge &2, expand(&1, &2, user_opts, opts))
  end
  defp single rules, opts, user_opts, globals do
    reduce_while rules, opts, &(cont_single? merge &2, expand(&1, &2, user_opts, globals))
  end

  defp list(rules, opts, user_opts, globals) when is_list(user_opts) and (length(opts) == length(user_opts)) do
    zip(opts, user_opts) |> map(&(resolve_raw rules, elem(&1,0), elem(&1,1), globals))
  end
  defp list rules, opts, _, globals do
    opts |> map(&(resolve_raw rules, &1, %{}, globals))
  end

end