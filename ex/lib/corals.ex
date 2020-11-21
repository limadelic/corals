defmodule Corals do
  alias Corals.Rules

  def define name, spec \\ %{} do
    Rules.define name, spec
  end

  def resolve context, rules, opts \\ %{} do
    Rules.resolve context, rules, opts
  end

  defmacro is? pattern do
    quote do
      fn unquote(pattern) -> true; _ -> false end
    end
  end

end
