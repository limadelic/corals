defmodule Corals.Server do
  use GenServer

  alias Corals.Rules
  import Corals.Resolver
  import Corals.Helpers

  def start_link name, spec do
    GenServer.start_link __MODULE__, spec, name: name
  end

  def init spec do {:ok, spec} end

  def handle_call {:resolve, opts}, _, %{require: deps, rules: rules} = spec do
    context = Rules.resolve_raw deps, opts
    {:reply, {:ok, resolve_raw(rules, context, opts)}, spec}
  end

end