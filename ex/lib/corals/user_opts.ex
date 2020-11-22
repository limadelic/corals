defmodule Corals.UserOpts do

  import Corals.Helpers

  defguard is_user_opt?(opt, user_opts) when :erlang.is_map_key(opt, user_opts)

  def user_opt_value {opt, v} = tuple do
    cond do
      is_overridden? opt -> {overridden(opt), v}
      true -> tuple
    end
  end

  defp is_overridden? opt do ends_with? opt, "!" end
  defp overridden opt do "#{opt}" |> String.slice(0..-2) |> String.to_atom end

end