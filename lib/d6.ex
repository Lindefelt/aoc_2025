defmodule D6 do
  require Integer

  defp parse_input() do
    lines = "data/06/input.txt"
    |> File.read!()
    |> String.split("\n")

    lines |> Enum.map(fn line -> line |> String.split()end )

  end
  defp transpose(list) do
    list |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  defp solve_p1(data) do
    IO.inspect(data)
    transposed = data |> transpose()
    IO.inspect(transposed)

    transposed |> Enum.reduce(0,fn row,acc ->
       {_,op} = row |> Enum.fetch(length(row)-1)
       IO.inspect(op)
       #IO.inspect(row)
      operands = row |> Enum.drop(-1) |> Enum.map(&String.to_integer/1)
      IO.inspect(operands)

      res = cond do
        op == "+" -> Enum.reduce(operands,&+/2)
        op == "*" -> Enum.reduce(operands,&*/2)
      end
      acc+res
      end )


  end



#defp solve_p2({data) do
#  ranges
#  |> merge_ranges()
#  |> Enum.map(&Range.size/1)
#  |> Enum.sum()
#end


  def main() do
    data = parse_input()
    #IO.inspect(data)


    {time_p1, result_p1} = :timer.tc(fn -> solve_p1(data) end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    #{time_p2, result_p2} = :timer.tc(fn -> solve_p2(data) end)
    #IO.puts("P2: #{result_p2}")
    #IO.puts("µs P2: #{time_p2}")
  end
end
