defmodule Corals.Loader do

  import Path, only: [wildcard: 1]
  import Enum, only: [uniq: 1, map: 2]

  @corals_files "**/corals/**/*rules.exs"

  def start app do Task.Supervisor.start_child Corals.TaskSupervisor, &run/0; app end

  def run do corals_files() |> map(&Code.require_file/1) end

  defp corals_files do @corals_files |> wildcard |> uniq end

end