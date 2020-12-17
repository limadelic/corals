defmodule Reef.RulesModel do

  import Reef.Helpers
  import Enum, only: [map: 2, filter: 2]

  def index do %{ rules: rules } end

  defp rules do Process.list |> map(&Process.info/1) |> filter(&is_corals?/1) |> map(&info/1) end

  defp is_corals? rules do match? {Corals.Server, _, _}, rules[:dictionary][:"$initial_call"] end

  defp info rules do
    %{
      name: rules[:registered_name]
    }
  end

end