defmodule Corals.Expander do

  alias Corals.Resolver

  import Corals.When
  import Corals.Opts
  import Corals.Fun

  def expand {:when, cond}, context, _ do do_when cond, context end
  def expand {:when!, cond}, context, _ do do_when! cond, context end
  def expand({k, v}, context, opts) when is_list v do
    {k,  Resolver.resolve_raw(v, context[k] || %{}, opts[k] || %{})}
  end
  def expand({k, _}, context, opts) when is_opt? k, opts do context end
  def expand({k, f}, context, _) when is_function f do {k, fun(f, context)} end
  def expand {opt, v} = tuple, _, _ do
    cond do
      is_overridden? opt -> {overridden(opt), v}
      true -> tuple
    end
  end

end