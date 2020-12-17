defmodule Reef.HomeModel do

  import Reef.Helpers

  def index do
    %{
      home: %{
        links: [
          %{id: "self", method: "GET", href: url()},
          %{id: "home", method: "GET", href: url()},
          %{id: "resolve", method: "POST", href: url()},
          %{id: "rules", method: "GET", href: link("rules")}
        ]
      }
    }
  end

end