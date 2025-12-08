defmodule D8 do
  require Integer

  defp parse_input() do
    lines = "data/08/test.txt"
    |> File.read!()
    |> String.split()

    split = lines
    |> Enum.map(fn line -> line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end )

  end

  defp distance(p1,p2) do
    {x1,y1,z1} = p1
    {x2,y2,z2} = p2
    #sqrt not needed
    :math.sqrt(Integer.pow(x2 - x1,2) + Integer.pow(y2 - y1,2) + Integer.pow(z2 - z1,2))

  end
  defp solve_p1(circuits) do

      pairs = create_pairs(circuits)
      pairs_sorted = Enum.sort_by(pairs, fn {d,_,_} -> d end)

      connected = connect(circuits,pairs_sorted,1000)
          components = components(connected)

          res = components |> Enum.sort_by(fn l -> length(l) end, :desc)
          IO.inspect(res)
          res |> Enum.take(3)|> Enum.reduce( 1, fn l, acc -> acc * length(l) end)

  end
  defp create_pairs(boxes) do
    indexed_boxes = Enum.with_index(boxes)
    for {c1,i} <- indexed_boxes,
        {c2,j} <- indexed_boxes,
        j > i do
      d = distance(c1,c2)
      {d, c1, c2}
    end
  end

defp connect(circuits,pairs,times) do

   cs = Enum.take(pairs,times)


   map = circuits |> Enum.into(%{}, fn c -> {c, c} end)

   map = Enum.reduce(cs,map, fn {d,c1,c2}, acc_map ->
    root1 = find(acc_map,c1)
    root2 = find(acc_map,c2)

    if root1 != root2 do
      Map.put(acc_map,root2,root1)
    else
      acc_map
    end
   end)


end

defp find(map, item) do
  parent = Map.get(map,item)

  if parent == item do
    item
  else
    find(map,parent)
  end
end
defp components(parent_map) do
  parent_map
  |> Map.keys()
  |> Enum.group_by(fn c -> find(parent_map, c) end)
  |> Map.values()
end

#  defp solve_p2(circuits) do
#       pairs = create_pairs(circuits)
#       pairs_sorted = Enum.sort_by(pairs, fn {d,_,_} -> d end)

#       connected = connect(circuits,pairs_sorted,1000000000)
#       components = components(connected)
#       IO.inspect(components)


#  end



  def main() do
    data = parse_input()

    {time_p1, result_p1} = :timer.tc(fn -> solve_p1(data) end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    # {time_p2, result_p2} = :timer.tc(fn -> solve_p2(data) end)
    # IO.puts("P2: #{result_p2}")
    # IO.puts("µs P2: #{time_p2}")
  end
end
