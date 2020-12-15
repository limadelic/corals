defmodule Corals.Loader do

  def start app do
    Task.Supervisor.start_child Corals.TaskSupervisor, &run/0
    app
  end

  def run do
    IO.inspect File.cwd
  end

end