defmodule Reef.HomeModel do

  import Reef.Helpers

  def index do
    %{
      home: %{
        links: [
          %{id: "self", href: url()},
          %{id: "home", href: url()},
          %{id: "resolve", method: "POST", href: url()},
#          %{id: "rules", href: link("rules")}
        ]
      }
    }
  end

end