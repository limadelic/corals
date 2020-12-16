defmodule Reef.Router do
  use Reef, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Reef do
    pipe_through :api

    get "/", HomeController, :index
    post "/", RulesController, :resolve
    post "/:rules", RulesController, :resolve
  end

end
