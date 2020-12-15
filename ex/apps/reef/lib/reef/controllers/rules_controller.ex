defmodule Reef.RulesController do
  use Reef, :controller

  import Corals.Helpers

  def resolve conn, params do
    json conn, Corals.resolve(atomic params)
  end

end