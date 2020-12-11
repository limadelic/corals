defmodule Reef.HomeController do
  use Reef, :controller

  def index conn, _ do
    json conn, %{corals: 'hello'}
  end
end