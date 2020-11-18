defmodule Corals.Expander do

  alias Corals.Resolver

  import Corals.{When, Opts, Fun}

  def expand {:when, cond}, context, _, globals do do_when cond, context, globals end
  def expand {:when!, cond}, context, _, globals do do_when! cond, context, globals end

  def expand({k, v}, context, opts, globals) when is_list v do
    {k,  Resolver.resolve_raw(v, context[k] || %{}, opts[k] || %{}, globals)}
  end

  def expand({k, _}, context, opts, _) when is_opt? k, opts do context end

  def expand({k, f}, context, _, globals) when is_function f do
    expand {k, fun(f, context, globals)}, nil, nil, nil
  end

  def expand {opt, v} = tuple, _, _, _ do
    cond do
      is_overridden? opt -> {overridden(opt), v}
      true -> tuple
    end
  end

end