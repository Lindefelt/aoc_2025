defmodule Mix.Tasks.D7 do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    D7.main()
  end
end
