defmodule Corals.Single do

  alias Corals.Resolver

  import Corals.When
  import Corals.Opts
  import Corals.Fun
  import Corals.Utils
  import Enum, only: [reduce_while: 3]

  def is_single? rules do Keyword.keyword? rules end

  def single rules, context, opts do
    reduce_while rules, context, &(expand &1, &2, opts)
  end

  defp expand {:when, cond}, context, _ do do_when cond, context end
  defp expand({k, v}, context, opts) when is_list v do
    {:cont, merge(context, {k,  Resolver.resolve(v, context[k] || %{}, opts[k] || %{})})}
  end
  defp expand({k, _}, context, opts) when is_opt? k, opts do {:cont, context} end
  defp expand({k, f}, context, _) when is_function f do
    {:cont, merge(context, {k, fun(f, context)})}
  end
  defp expand {opt, v} = tuple, context, _ do
    cond do
      is_overridden? opt -> {:cont, merge(context, {overridden(opt), v})}
      true -> {:cont, merge(context, tuple)}
    end
  end

end