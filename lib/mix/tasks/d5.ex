defmodule Mix.Tasks.D5 do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    D5.main()
  end
end
