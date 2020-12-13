defmodule Reef.RulesController do
  use Reef, :controller

  import Corals

  def evolve conn, %{"rules" => rules} do
    json conn, resolve(%{}, rules)
  end

end