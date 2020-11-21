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

  def resolve opts, rules, user_opts do
    opts |> merge(user_opts) |> resolve_raw(rules, user_opts) |> clean
  end

  def resolve_raw opts, [], _ do opts end

  def resolve_raw(opts, rules, user_opts) when is_list(rules) do
    rules
    |> async_stream(&(resolve_raw opts, &1, user_opts))
    |> reduce(%{}, &(merge &2, elem(&1, 1)))
  end

  def resolve_raw opts, rules, user_opts do
    rules |> GenServer.call({:resolve, opts, user_opts}) |> elem(1)
  end

end