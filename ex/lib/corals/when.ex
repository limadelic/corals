defmodule Corals.When do

  import Corals.Fun
  import Map, only: [merge: 2]

  def do_when cond, context, globals do done context, eval(cond, context, globals) end
  def do_when! cond, context, globals do done! context, eval(cond, context, globals) end

  defp done context, true do context end
  defp done context, _ do merge context, %{_halt_: true} end
  defp done! context, true do merge context, %{__halt__: true} end
  defp done! context, _ do merge context, %{_halt_: true} end

  defp eval(cond, context, globals) when is_function cond do fun cond, context, globals end
  defp eval cond, _, _ do cond end

end