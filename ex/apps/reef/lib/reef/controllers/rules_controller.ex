defmodule Reef.RulesController do
  use Reef, :controller

  def evolve conn, %{"rules" => rules} do
    json conn, %{rules: rules}
  end

end