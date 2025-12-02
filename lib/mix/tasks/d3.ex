defmodule Mix.Tasks.D2 do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    D2.main()
  end
end
