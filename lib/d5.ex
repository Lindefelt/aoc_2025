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
    #IO.inspect(ranges)
    #IO.inspect(ids)

    {ranges,ids}
  end

  defp solve_p1(data) do
    {ranges,ids} = data

   fresh = ids
   |> Enum.filter(fn id -> Enum.any?(ranges, fn range -> id in range end )end)
  Enum.count(fresh)
  end

 def merge_ranges(ranges) do
  ranges
  |> Enum.sort_by(& &1.first)
  |> Enum.reduce([], fn r, acc ->
    case acc do
      [] ->
        [r]

      [prev | rest] ->
        if r.first <= prev.last + 1 do
          merged = prev.first..max(prev.last, r.last)
          [merged | rest]
        else
          [r | acc]
        end
    end
  end)

end

defp solve_p2({ranges, _ids}) do
  ranges
  |> merge_ranges()
  |> Enum.map(&Range.size/1)
  |> Enum.sum()
end


  def main() do
    data = parse_input()
    #IO.inspect(data)


    {time_p1, result_p1} = :timer.tc(fn -> solve_p1(data) end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    {time_p2, result_p2} = :timer.tc(fn -> solve_p2(data) end)
    IO.puts("P2: #{result_p2}")
    IO.puts("µs P2: #{time_p2}")
  end
end
