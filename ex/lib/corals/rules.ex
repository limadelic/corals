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

  def resolve rules, opts do
    rules |> resolve_raw(opts) |> clean
  end

  def resolve_raw [], opts do opts end

  def resolve_raw(rules, opts) when is_list(rules) do
    rules
    |> async_stream(&(resolve_raw &1, opts))
    |> reduce(%{}, &(merge &2, elem(&1, 1)))
  end

  def resolve_raw rules, opts do
    rules |> GenServer.call({:resolve, opts}) |> elem(1)
  end

end