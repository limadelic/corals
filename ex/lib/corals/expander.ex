defmodule Corals.Expander do

  alias Corals.Resolver
  import Map, only: [merge: 2]
  import Function, only: [info: 2]

  def expand({k, v}, context) when is_list(v) do
    add {k,  Resolver.resolve(v)}, context
  end
  def expand({k, v}, context) when is_function(v) do
    expand_fn {k, v}, context, info(v, :arity)
  end
  def expand tuple, context do add tuple, context end

  defp expand_fn {k, v}, context, {_, 1} do add {k, v.(context)}, context end
  defp expand_fn {k, v}, context, _ do add {k, v.()}, context end

  defp add {k, v}, map do merge map, %{k => v} end

end