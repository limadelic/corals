defmodule Corals.Rules do

  alias Corals.Server

  def define name, spec do
    DynamicSupervisor.start_child Corals.RulesSupervisor, %{
      id: Server,
      start: {Server, :start_link, [name, spec]}
    }
  end

  def resolve rules, opts do
    {:ok, result} = GenServer.call rules, {:resolve, %{}, opts}
    result
  end

end