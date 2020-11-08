defmodule Corals do
  alias Corals.Rules

  def define name, spec do
    Rules.define name, spec
  end

  def resolve name do
    {:ok, result} = Rules.resolve name
    result
  end

end
