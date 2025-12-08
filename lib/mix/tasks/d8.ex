defmodule Mix.Tasks.D8 do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    D8.main()
  end
end
