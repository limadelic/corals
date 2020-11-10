defmodule Corals.Expander do

  alias Corals.Resolver
  import Corals.Utils
  import Function, only: [info: 2]
  import String, only: [slice: 2, to_atom: 1]

  def expand({k, _}, context, opts) when :erlang.is_map_key(k, opts) do context end
  def expand({k, v}, context, opts) when is_list(v) do
    merge context, {k,  Resolver.resolve(v, context[k] || %{}, opts || %{})}
  end
  def expand({k, v}, context, _) when is_function(v) do
    expand_fn {k, v}, context, info(v, :arity)
  end
  def expand {k, v} = tuple, context, _ do
    case slice "#{k}", -1..-1 do
      "!" -> merge context, {to_atom(slice("#{k}", 0..-2)), v}
      _ -> merge context, tuple
    end
  end

  defp expand_fn {k, v}, context, {_, 1} do merge context, {k, v.(context)} end
  defp expand_fn {k, v}, context,  _ do merge context, {k, v.()} end

end