defmodule Reef.RulesModel do

  import Reef.Helpers
  import Enum, only: [map: 2, filter: 2]

  def index do
    %{
      rules: rules
    }
  end

  defp rules do
    Process.list
    |> map(&Process.info/1)
    |> Enum.filter(&(match? {Corals.Server, _, _}, &1[:dictionary][:"$initial_call"]))
    |> map(&info/1)
  end

  defp info rules do
    %{
      name: rules[:registered_name]
    }
  end

end