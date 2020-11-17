defmodule Corals.Server do
  use GenServer

  alias Corals.Resolver

  def start_link name, spec do
    GenServer.start_link __MODULE__, spec, name: name
  end

  def init spec do {:ok, spec} end

  def handle_call {:resolve, context, opts}, _, %{rules: rules} = spec do
    {:reply, {:ok, Resolver.resolve(rules, context, opts)}, spec}
  end

end