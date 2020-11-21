defmodule Corals.Expander do

  alias Corals.Resolver

  import Corals.{When, UserOpts, Fun}

  def expand {:when, cond}, opts, _, globals do do_when cond, opts, globals end
  def expand {:when!, cond}, opts, _, globals do do_when! cond, opts, globals end

  def expand({k, v}, opts, user_opts, globals) when is_list v do
    {k,  Resolver.resolve_raw(v, opts[k] || %{}, user_opts[k] || %{}, globals)}
  end

  def expand({k, _}, opts, user_opts, _) when is_user_opt? k, user_opts do opts end

  def expand({k, f}, opts, _, globals) when is_function f do
    expand {k, fun(f, opts, globals)}, nil, nil, nil
  end

  def expand {opt, v} = tuple, _, _, _ do
    cond do
      is_overridden? opt -> {overridden(opt), v}
      true -> tuple
    end
  end

end