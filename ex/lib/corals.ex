defmodule Corals do
  alias Corals.Rules

  def define name, spec \\ %{} do
    Rules.define name, spec
  end

  def resolve rules, opts \\ %{} do
    Rules.resolve rules, opts
  end

  defmacro is? pattern do
    quote do
      fn unquote(pattern) -> true; _ -> false end
    end
  end

end
