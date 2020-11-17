defmodule Corals.Rules do

  alias Corals.Server
  import Corals.Helpers
  import Enum, only: [reduce: 3]
  import Task, only: [async_stream: 2]

  def define name, spec do
    DynamicSupervisor.start_child Corals.RulesSupervisor, %{
      id: Server,
      start: {Server, :start_link, [name, spec]}
    }
  end

  def resolve(rules, opts) when is_list(rules) do
    rules
    |> async_stream(&(resolve &1, opts))
    |> reduce(%{}, &(merge &2, elem(&1, 1)))
  end

  def resolve rules, opts do
    elem GenServer.call(rules, {:resolve, %{}, opts}), 1
  end

end