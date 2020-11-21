defmodule Corals do
  alias Corals.Rules

  def define name, spec \\ %{} do
    Rules.define name, spec
  end

  def resolve opts, rules, user_opts \\ %{} do
    Rules.resolve opts, rules, user_opts
  end

  defmacro is? pattern do
    quote do
      fn unquote(pattern) -> true; _ -> false end
    end
  end

end
