defmodule Mix.Tasks.D3 do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    D3.main()
  end
end
