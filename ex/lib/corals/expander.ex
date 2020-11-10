defmodule Corals.Expander do

  alias Corals.Resolver
  import Corals.When
  import Corals.Opts
  import Corals.Utils

  def expand {:when, cond}, context, _ do do_when cond, context end
  def expand({k, v}, context, opts) when is_list v do
    {:cont, merge(context, {k,  Resolver.resolve(v, context[k] || %{}, opts[k] || %{})})}
  end
  def expand({k, _}, context, opts) when is_opt? k, opts do {:cont, context} end
  def expand({k, f}, context, _) when is_function f do
    {:cont, expand_fn({k, f}, context, Function.info(f, :arity))}
  end
  def expand {opt, v} = tuple, context, _ do
    cond do
      is_overridden? opt -> {:cont, merge(context, {overridden(opt), v})}
      true -> {:cont, merge(context, tuple)}
    end
  end

  defp expand_fn {k, f}, context, {_, 1} do merge context, {k, f.(context)} end
  defp expand_fn {k, f}, context,  _ do merge context, {k, f.()} end

end