defmodule D3 do
  require Integer

  defp parse_input() do
    "data/03/input.txt"
    |> File.read!()
    |> String.split(",")

  end



  defp solve_p1(data) do
    "a"
  end


  defp solve_p2(data) do
    "b"
  end

  def main() do
    data = parse_input()
    #IO.inspect(data)
    d = Enum.map(data, fn s  -> String.split(s,"-") end) |> Enum.map( fn [a,b] -> {String.to_integer(a), String.to_integer(b)} end)
    #IO.inspect(d)

    {time_p1,result_p1} = :timer.tc( fn -> solve_p1(d)end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    {time_p2,result_p2} = :timer.tc( fn -> solve_p2(d)end)
    IO.puts("P2: #{result_p2}")
    IO.puts("µs P2: #{time_p2}")

  end
end
