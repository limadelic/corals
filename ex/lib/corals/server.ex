defmodule Corals.Server do
  use GenServer

  alias Corals.Rules
  import Corals.Resolver

  def start_link name, spec do
    GenServer.start_link __MODULE__, spec, name: name
  end

  def init spec do {:ok, spec} end

  def handle_call {:resolve, context, opts}, _, %{require: deps, rules: rules} = spec do
    {:reply, {:ok, resolve(context, opts, deps, rules)}, spec}
  end

  defp resolve context, opts, deps, rules do
    context = context |> Rules.resolve_raw(deps, opts)
    resolve_raw(rules, context, opts)
  end

end