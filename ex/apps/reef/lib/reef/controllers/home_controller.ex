defmodule Reef.HomeController do
  use Reef, :controller

  alias Reef.HomeModel, as: Model

  def index conn, _ do
    json conn, Model.index
  end
end