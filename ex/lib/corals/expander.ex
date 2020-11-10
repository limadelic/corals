defmodule Corals.Expander do

  alias Corals.Resolver
  import Corals.Utils
  import Function, only: [info: 2]

  def expand({k, v}, context) when is_list(v) do
    merge context, {k,  Resolver.resolve(v, context[k] || %{})}
  end
  def expand({k, v}, context) when is_function(v) do
    expand_fn {k, v}, context, info(v, :arity)
  end
  def expand tuple, context do merge context, tuple end

  defp expand_fn {k, v}, context, {_, 1} do merge context, {k, v.(context)} end
  defp expand_fn {k, v}, context, _ do merge context, {k, v.()} end

end