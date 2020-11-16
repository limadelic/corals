defmodule Corals.When do

  import Corals.Fun
  import Map, only: [merge: 2]

  def do_when cond, context do done context, eval(cond, context) end
  def do_when! cond, context do done! context, eval(cond, context) end

  defp done context, true do {:cont, context} end
  defp done context, _ do {:halt, context} end
  defp done! context, true do {:cont, merge(context, %{__halt__: true})} end
  defp done! context, _ do {:halt, context} end

  defp eval(cond, context) when is_function cond do fun cond, context end
  defp eval cond, _ do cond end

end