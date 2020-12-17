defmodule Reef.RulesModel do

  import Corals.Utils, only: [is_corals?: 1]
  import Reef.Helpers
  import Enum, only: [map: 2, filter: 2]

  def index do %{ rules: rules } end

  defp rules do Process.list |> map(&Process.info/1) |> filter(&is_corals?/1) |> map(&info/1) end

  defp info rules do
    name = rules[:registered_name]
    %{
      name: name,
      links: [
        %{id: "self", method: "GET", href: link(name)},
        %{id: "resolve", method: "POST", href: link(name)},
      ]
    }
  end

end