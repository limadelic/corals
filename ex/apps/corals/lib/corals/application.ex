defmodule Corals.Application do
  use Application

  @impl true
  def start _, _ do
    Corals.Loader.start Corals.Supervisor.start_link name: Corals.Supervisor
  end

end