defmodule Corals.Server do
  use GenServer

  alias Corals.{Rules, Resolver}

  def start_link name, spec do
    GenServer.start_link __MODULE__, spec, name: name
  end

  def init spec do {:ok, spec} end

  def handle_call {:resolve, opts}, _, %{requires: deps, rules: rules} = spec do
    context = Rules.resolve_raw deps, opts
    {:reply, {:ok, Resolver.resolve_raw(rules, context, opts)}, spec}
  end

end