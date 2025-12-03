defmodule D3 do
  require Integer

  defp parse_input() do
    "data/03/input.txt"
    |> File.read!()
    |> String.split()

  end



  defp solve_p1(data) do
    integers = Enum.map(data, fn d -> d|>String.graphemes()|>Enum.map(&String.to_integer/1) end)
    IO.inspect(integers)

    Enum.map(integers, fn d -> find_maxes(d)  end)|> Enum.sum()

  end

  defp find_maxes(ints) do
   left = {left_val, left_idx} =
    ints
    |> Enum.drop(-1)
    |> Enum.with_index()
    |> Enum.max_by(fn {v, _i} -> v end)

    right = {right_val, _} =
    ints
    |> Enum.drop(left_idx+1)
    |> Enum.with_index()
    |> Enum.max_by(fn {v, _i} -> v end)
    IO.inspect(left)
    IO.inspect(right)

   val = "#{left_val}#{right_val}"

    IO.puts("Val: #{val}")

    String.to_integer(val)
  end

  defp find_max(ints,n) do
    ints |> Enum.with_index()
    IO.inspect(ints)

    val = find_max(ints,0,n,[])
    val|>Enum.join("")|>String.to_integer()

  end
  #end condition remaining = 0
  defp find_max(_,_,0,acc), do: Enum.reverse(acc)



  defp find_max(ints,index, remaining,acc) do
  end_index = length(ints) - remaining
    {val,index_picked}=
      ints
      |>Enum.with_index()
      |>Enum.slice(index..end_index)
      |>Enum.max_by(fn {v,_i} -> v end)

    find_max(ints,index_picked+1,remaining-1,[val|acc])

  end

  defp solve_p2(data) do
    integers = Enum.map(data, fn d -> d|>String.graphemes()|>Enum.map(&String.to_integer/1) end)

    #max = find_max([8,1,1,1,1,1,1,1,1,1,1,1,1,1,9],12)

    #IO.puts(max)
    Enum.map(integers, fn d -> find_max(d,12)  end)|> Enum.sum()

  end

  def main() do
    data = parse_input()
    IO.inspect(data)
    d = data
    #IO.inspect(d)

    {time_p1,result_p1} = :timer.tc( fn -> solve_p1(d)end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    {time_p2,result_p2} = :timer.tc( fn -> solve_p2(d)end)
    IO.puts("P2: #{result_p2}")
    IO.puts("µs P2: #{time_p2}")

  end
end
