defmodule Reef.Router do
  use Reef, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Reef do
    pipe_through :api
  end
end
