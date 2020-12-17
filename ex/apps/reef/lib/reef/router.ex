defmodule Reef.Router do
  use Reef, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Reef do
    pipe_through :api

    get "/", HomeController, :index
    get "/rules", RulesController, :index
    get "/rules/:name", RulesController, :show
    post "/", RulesController, :resolve
    post "/:rules", RulesController, :resolve
  end

end
