defmodule Corals.Rules do
  use GenServer

  alias Corals.Resolver

  def define name, spec do
    DynamicSupervisor.start_child Corals.RulesSupervisor, %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [name, spec]}
    }
  end

  def resolve name do
    {:ok, result} = GenServer.call name, {:resolve}
    result
  end

  def start_link name, spec do
    GenServer.start_link __MODULE__, spec, name: name
  end

  def init spec do {:ok, spec} end

  def handle_call {:resolve}, _, %{rules: rules} = spec do
    {:reply, {:ok, Resolver.resolve(rules)}, spec}
  end

end