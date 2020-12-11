defmodule Reef.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Reef.Telemetry,
      # Start the Endpoint (http/https)
      Reef.Endpoint
      # Start a worker by calling: Reef.Worker.start_link(arg)
      # {Reef.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Reef.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Reef.Endpoint.config_change(changed, removed)
    :ok
  end
end
