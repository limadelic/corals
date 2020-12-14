defmodule Reef.RulesController do
  use Reef, :controller

  def resolve conn, %{"rules" => rules} do
    json conn, Corals.resolve(%{}, rules)
  end

end