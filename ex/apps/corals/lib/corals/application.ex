defmodule Corals.Application do
  use Application

  @impl true
  def start _, _ do
    Corals.Supervisor.start_link name: Corals.Supervisor
  end

end