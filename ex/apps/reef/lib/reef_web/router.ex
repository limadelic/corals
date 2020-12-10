defmodule ReefWeb.Router do
  use ReefWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReefWeb do
    pipe_through :api
  end
end
