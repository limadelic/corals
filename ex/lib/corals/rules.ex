defmodule Corals.Rules do

  alias Corals.Server

  import Corals.{Utils, Helpers}
  import Enum, only: [reduce: 3]
  import Task, only: [async_stream: 2]

  @defaults %{
    require: [],
    rules: []
  }

  def define name, spec do
    DynamicSupervisor.start_child Corals.RulesSupervisor, %{
      id: Server,
      start: {Server, :start_link, [name, merge(@defaults, spec)]}
    }
  end

  def resolve context, rules, opts do
    context |> merge(opts) |> resolve_raw(rules, opts) |> clean
  end

  def resolve_raw context, [], _ do context end

  def resolve_raw(context, rules, opts) when is_list(rules) do
    rules
    |> async_stream(&(resolve_raw context, &1, opts))
    |> reduce(%{}, &(merge &2, elem(&1, 1)))
  end

  def resolve_raw context, rules, opts do
    rules |> GenServer.call({:resolve, context, opts}) |> elem(1)
  end

end