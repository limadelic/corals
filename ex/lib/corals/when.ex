defmodule Corals.When do

  def do_when cond, context do
    done context, eval(cond, context)
  end

  defp done context, true do {:cont, context} end
  defp done context, _ do {:halt, context} end

  defp eval cond, _ do cond end

end