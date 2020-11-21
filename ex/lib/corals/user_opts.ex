defmodule Corals.UserOpts do

  import Corals.Helpers

  defguard is_user_opt?(opt, user_opts) when :erlang.is_map_key(opt, user_opts)

  def is_overridden? opt do ends_with? opt, "!" end
  def overridden opt do "#{opt}" |> String.slice(0..-2) |> String.to_atom end

end