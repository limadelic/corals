defmodule Corals.Expander do

  import Map, only: [merge: 2]
  import Function, only: [info: 2]

  def expand({k, v}, map) when is_function(v) do
    case info v, :arity do
      {_, 1} -> add {k, v.(map)}, map
      _ -> add {k, v.()}, map
    end
  end

  def expand tuple, map do add tuple, map end

  defp add {k, v}, map do merge map, %{k => v} end

end