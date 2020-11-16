defmodule Corals.Supervisor do
  use Supervisor

  def start_link opts do
    Supervisor.start_link __MODULE__, :ok, opts
  end

  @impl true
  def init :ok do
    children = [
      {DynamicSupervisor, name: Corals.RulesSupervisor, strategy: :one_for_one},
    ]
    Supervisor.init children, strategy: :one_for_all
  end
end