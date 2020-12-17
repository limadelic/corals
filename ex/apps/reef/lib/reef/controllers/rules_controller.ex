defmodule Reef.RulesController do
  use Reef, :controller

  import Corals.Helpers
  alias Reef.RulesModel, as: Model

  def index conn, _ do
    json conn, Model.index
  end

  def show conn, %{"name" => name} do
    text conn, Corals.Loader.content name
  end

  def resolve conn, params do
    json conn, Corals.resolve(atomic params)
  end

end