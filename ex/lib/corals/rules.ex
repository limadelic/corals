defmodule Corals.Rules do
  use GenServer

  def define name, spec do
    GenServer.start_link __MODULE__, spec, name: name
  end

  def resolve name do
    GenServer.call name, {:resolve}
  end

  def init spec do {:ok, spec} end

  def handle_call {:resolve}, _, %{rules: rules} = spec do
    {:reply, {:ok, Enum.at(rules, 0)}, spec}
  end

end