defmodule Mix.Tasks.D4 do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    D4.main()
  end
end
