defmodule Corals.Server do
  use GenServer

  alias Corals.Rules
  import Corals.Resolver

  def start_link name, spec do
    GenServer.start_link __MODULE__, spec, name: name
  end

  def init spec do {:ok, spec} end

  def handle_call {:resolve, opts, user_opts}, _, %{require: deps, rules: rules} = spec do
    {:reply, {:ok, resolve(opts, user_opts, deps, rules)}, spec}
  end

  defp resolve opts, user_opts, deps, rules do
    opts |> Rules.resolve_raw(deps, user_opts) |> resolve_raw(rules, user_opts)
  end

end