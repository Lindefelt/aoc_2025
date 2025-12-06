defmodule Mix.Tasks.D6 do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    D6.main()
  end
end
