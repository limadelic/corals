defmodule Corals.Utils do

  def merge {k, v}, map do Map.merge map, %{k => v} end
  def merge left, right do Map.merge left, right, &deep/3 end

  defp deep _, left=%{}, right=%{} do merge left, right end
  defp deep _, _, right do right end

end