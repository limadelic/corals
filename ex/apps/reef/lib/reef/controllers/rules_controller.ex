defmodule Reef.RulesController do
  use Reef, :controller

  import String, only: [to_existing_atom: 1]

  def resolve conn, %{"rules" => rules} do
    json conn, Corals.resolve(%{}, to_existing_atom(rules))
  end

end