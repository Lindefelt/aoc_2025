defmodule D5 do
  require Integer

  defp parse_input() do
    data = "data/05/input.txt"
    |> File.read!()
    |> String.split("\n\n")

    [d1,d2] = data

    ranges = d1
    |> String.split()
    |> Enum.map( fn partial -> partial
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
      |> then( fn [s,e] -> s..e end) end)
    ids = d2 |> String.split() |> Enum.map(&String.to_integer/1)
    IO.inspect(ranges)
    IO.inspect(ids)

    {ranges,ids}
  end

  defp digits_per_row(data) do
    Enum.map(data, fn d ->
      d |> String.graphemes() |> Enum.map(&String.to_integer/1)
    end)
  end


  defp solve_p1(data) do
    {ranges,ids} = data

   fresh = ids
   |> Enum.filter(fn id -> Enum.any?(ranges, fn range -> id in range end )end)
  Enum.count(fresh)
  end

defp solve_p2({ranges, _ids}) do
  ranges
  |> Enum.reduce(MapSet.new(), fn r, set ->
    Enum.reduce(r, set, &MapSet.put(&2, &1))
  end)
  |> MapSet.size()
end


  def main() do
    data = parse_input()
    IO.inspect(data)


    {time_p1, result_p1} = :timer.tc(fn -> solve_p1(data) end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    {time_p2, result_p2} = :timer.tc(fn -> solve_p2(data) end)
    IO.puts("P2: #{result_p2}")
    IO.puts("µs P2: #{time_p2}")
  end
end
