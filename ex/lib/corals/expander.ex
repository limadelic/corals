defmodule Corals.Expander do

  alias Corals.Resolver, as: R

  import Corals.{Helpers, When, Opts, Fun}
  import Enum, only: [zip: 2]

  def expand {:when, cond}, context, _, globals do do_when cond, context, globals end
  def expand {:when!, cond}, context, _, globals do do_when! cond, context, globals end

  def expand({k, v}, context, opts, globals) when is_list v do
    cond do
      is_map_list(context[k]) && R.is_single?(v) ->
        {k, expand_list(v, context[k], zip(context[k], opts[k] || []), globals)}
      true -> {k,  R.resolve_raw(v, context[k] || %{}, opts[k] || %{}, globals)}
    end
  end

  def expand({k, _}, context, opts, _) when is_opt? k, opts do context end

  def expand({k, f}, context, _, globals) when is_function f do {k, fun(f, context, globals)} end

  def expand {opt, v} = tuple, _, _, _ do
    cond do
      is_overridden? opt -> {overridden(opt), v}
      true -> tuple
    end
  end

  defp expand_list list, context, [], globals do

  end
  defp expand_list list, _, context_opts, globals do

  end

end